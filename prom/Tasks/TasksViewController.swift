//
//  TasksViewController.swift
//  prom
//
//  Created by Deepak Sharma S M on 4/15/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

class TasksViewController: BaseUIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet weak var taskCategorySegmentControl: UISegmentedControl!

    @IBOutlet weak var maneuTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var menuLeadingContraint: NSLayoutConstraint!
    @IBOutlet weak var toggleMenu: UIBarButtonItem!
    
    let taskPresenter = TasksPresenter(taskService: TasksService())
    
    var newIdeas: [Task]?
    var proritizedTasks : [Task]?
    var myTasks: [Task]?
    
    var activeTasks: [Task]?
  
    var selectedStoryBoard: StoryBoard?
    var selectedTask: Task?
    var toggle: Bool = false
    
    var emptyStateView: EmptyStateView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
      
        self.navigationItem.title = selectedStoryBoard?.storyBoardTitle
        self.navigationItem.backBarButtonItem?.title = ""
        
        self.taskPresenter.getStoryBoardDetails(storyBoardId: (selectedStoryBoard?.storyBoardId)!)
        self.taskPresenter.attachView(view: self)
        
        emptyStateView = EmptyStateView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), nib: "EmptyState", image: UIImage.init(named: "list")!, message: "Got a great idea? Dont lose them. Create stories and features")
        
        view.sizeToFit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.activeTasks = nil
        self.taskPresenter.getStoryBoardTasks(storyboardId: (selectedStoryBoard?.storyBoardId)!)
        
    }
    
    
    @IBAction func onTaskCategotyChange(_ sender: Any) {
        let index = taskCategorySegmentControl.selectedSegmentIndex
        
        switch index {
        case 0:
            self.activeTasks = self.newIdeas
            self.tabelView.reloadData()
            break
        case 1:
            self.activeTasks = self.proritizedTasks
            self.tabelView.reloadData()
            break
        case 2:
            self.activeTasks = self.myTasks
            self.tabelView.reloadData()
            break
        default:
            break
        }
        
        if activeTasks == nil || (activeTasks?.isEmpty)! {
            self.tabelView.backgroundView = emptyStateView
        } else {
            self.tabelView.backgroundView = nil
        }

    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabelView.dequeueReusableCell(withIdentifier: "taskSummary") as! TaskViewCell
        cell.taskTitle.text = activeTasks?[indexPath.row].taskTitle
        cell.taskStatus.text = activeTasks?[indexPath.row].taskStatus
        cell.taskStatus.textColor = getTaskStatusColor(status: (activeTasks?[indexPath.row].taskStatus)!)
        cell.ownerInitials.setImageForName(string: "Deepak Sharma", backgroundColor: UIColor.lightGray, circular: true, textAttributes: nil, gradient: true)
        return cell
    }
    
    
    func getTaskStatusColor(status: String) -> UIColor {
        
        switch status {
        case "Working on it":
            return UIColor.orange
        case "Stuck":
            return UIColor.red
        case "Yet to start":
            return UIColor.lightText
        default:
            return UIColor.black
        }
        
    }
    
    @IBAction func onToggleMenu(_ sender: Any) {
        toggle = !toggle
        if(toggle) {
            taskCategorySegmentControl.isHidden = true
            maneuTrailingConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: { self.view.layoutIfNeeded()})
        } else {
            taskCategorySegmentControl.isHidden = false
            maneuTrailingConstraint.constant = -230.00
            UIView.animate(withDuration: 0.3, animations: { self.view.layoutIfNeeded()})
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onCreateNewTask(_ sender: Any) {
        performSegue(withIdentifier: "newTaskDetails", sender: self)
    }
    // MARK: - Table view data source

    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedTask = activeTasks?[indexPath.row]
        performSegue(withIdentifier: "taskDetails", sender: self)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return activeTasks?.count ?? 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskDetails" || segue.identifier == "taskDetails"{
            if let taskDetailsController = segue.destination as? TaskDetailsController {
                taskDetailsController.storyBoard = self.selectedStoryBoard!
                taskDetailsController.selectedTask = self.selectedTask
            }
        }
        
        if segue.identifier == "projectMenu" {
            print(segue.destination.description)
            if let menuVC = segue.destination as? MenuViewController {
                menuVC.selectedStory = self.selectedStoryBoard
                
            }
        }
        
        
    }
    
    
}
extension TasksViewController: TasksView {
    func setStoryBoard(storyBoard: StoryBoard) {
        self.selectedStoryBoard = storyBoard
        let storyBoardDefaults = UserDefaults.standard
        storyBoardDefaults.set(storyBoard.collaborators, forKey: "coll")
        storyBoardDefaults.synchronize()
    }
    

    func updateTasksView(newIdeas: [Task]?, proritize: [Task]?, myWork: [Task]?) {
        
        self.newIdeas = newIdeas
        self.proritizedTasks = proritize
        self.myTasks = myWork
        self.activeTasks = newIdeas
        
        if activeTasks == nil || (activeTasks?.isEmpty)! {
            self.tabelView.backgroundView = emptyStateView
        } else {
            self.tabelView.backgroundView = nil
        }
        
        self.tabelView.reloadData()
    }
    
    func updateUI() {
        
    }
    
    
}
