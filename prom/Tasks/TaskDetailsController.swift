//
//  TaskDetailsController.swift
//  prom
//
//  Created by Deepak Sharma S M on 4/15/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit
import Firebase

class TaskDetailsController: BaseUITableViewController, UIPickerViewDelegate, UIPickerViewDataSource ,TaskCollaboratorDelegate{
    
    @IBOutlet weak var taskDueDate: UITextField!
    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var taskDescriptionTextField: UITextView!
    @IBOutlet weak var estimateTextField: UITextField!
    @IBOutlet weak var phaseTextField: UITextField!
    @IBOutlet weak var collaboratorTextField: UILabel!
    @IBOutlet weak var taskOwnerTextField: UILabel!
    @IBOutlet weak var taskCategory: UISegmentedControl!
    
    var storyBoard: StoryBoard?
    var selectedTask: Task?
    
    var picker = UIDatePicker()
    var estimatePicker = UIPickerView()
    var phasePicker = UIPickerView()
    let estimatePoints = ["0 points", "1 point", "2 points", "3 points", "5 points"]
    let phases = ["Yet to start","Working on it","Stuck","Done"]
    var taskTitle: String?
    var taskDescription: String?
    var taskDue: String?
    var taskEstimate: String?
    var projectTitle: String?
    var category: String = "New Ideas"
    
    var taskCollaborator: ProMUser?
    var task: Task = Task(title: "", owner: FirebaseService().getCurrentUser()!)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        createEstimatePointsPicker()
        createPhasePicker()
        estimatePicker.dataSource = self
        estimatePicker.delegate = self
        phasePicker.delegate = self
        self.taskOwnerTextField.text = Auth.auth().currentUser?.displayName
        populateTaskDetails()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        let headerLabel = UILabel(frame: CGRect(x: 16, y: 8, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont.boldSystemFont(ofSize: 16)
        headerLabel.textColor = UIColor.black
        
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func populateTaskDetails() {
        if self.selectedTask != nil {
            self.task.taskId = selectedTask?.taskId
            self.taskTitleTextField.text = selectedTask?.taskTitle
            self.taskDescriptionTextField.text = selectedTask?.taskDescription
            self.taskDueDate.text = selectedTask?.dueDate
            self.estimateTextField.text = selectedTask?.points
            self.phaseTextField.text = selectedTask?.taskStatus
            self.collaboratorTextField.text = selectedTask?.taskCollaborators?.name
            self.taskCollaborator = selectedTask?.taskCollaborators
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.taskCollaborator != nil {
            self.collaboratorTextField.text = self.taskCollaborator?.name
        }
    }
    
    
    @IBAction func onAddCollaborator(_ sender: Any) {
        performSegue(withIdentifier: "pickMembers", sender: self)
    }
    
    @IBAction func onCategorySelection(_ sender: Any) {
        switch taskCategory.selectedSegmentIndex {
        case 0:
            self.category = "New Ideas"
            break
        case 1:
            self.category = "Prioritize"
            break
        default:
            self.category = "New Ideas"
            break
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case estimatePicker:
            return self.estimatePoints.count
        case phasePicker:
            return self.phases.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case estimatePicker:
            return estimatePoints[row]
        case phasePicker:
            return phases[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case estimatePicker:
            estimateTextField.text = estimatePoints[row]
        case phasePicker:
            phaseTextField.text = phases[row]
        default:
            print("default")
        }
    }
    
    func createDatePicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let dueDateDone = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        dueDateDone.tag = 1
        let removeDueDate = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(removePressed))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: #selector(removePressed))
        removeDueDate.tag = 2
        toolBar.setItems([dueDateDone, space, removeDueDate], animated: true)
        taskDueDate.inputAccessoryView = toolBar
        taskDueDate.inputView = picker
        picker.datePickerMode = .date
    }
    
    func createEstimatePointsPicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(onEstimateMade))
        toolBar.setItems([done], animated: true)
        estimateTextField.inputAccessoryView = toolBar
        estimateTextField.inputView = estimatePicker
    }
    
    func createPhasePicker() {
        let phasePickerToolbar = UIToolbar()
        phasePickerToolbar.sizeToFit()
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(onPhaseSelected))
        doneButtonItem.tag = 1
        let cancelButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(onPhaseSelectionCancel))
        cancelButtonItem.tag = 2
        let spaceButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        phasePickerToolbar.setItems([doneButtonItem, spaceButtonItem, cancelButtonItem], animated: true)
        self.phaseTextField.inputAccessoryView = phasePickerToolbar
        self.phaseTextField.inputView = phasePicker
    }
    
    @objc func onPhaseSelectionCancel() {
        self.phaseTextField.text = nil
        self.view.endEditing(true)
    }
    
    @objc func onPhaseSelected() {
        self.view.endEditing(true)
    }
    
    @objc func onEstimateMade() {
        self.view.endEditing(true)
    }
    
    @objc func donePressed() {
        let formatter = DateFormatter();
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        let dateString = formatter.string(from: picker.date)
        taskDueDate.text = "Due on \(dateString)"
        self.view.endEditing(true)
    }
    
    @objc func removePressed() {
        taskDueDate.text = nil
        self.view.endEditing(true)
    }
    
    @IBAction func OnPick(_ sender: Any) {
        performSegue(withIdentifier: "pickMembers", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    @IBAction func onTaskCreate(_ sender: Any) {
        guard taskTitleTextField.text != nil && !(taskTitleTextField.text?.isEmpty)! else {
            showError(title: "Required", message: "Task name cannot be empty", vc: self)
            return
        }
        
        let taskService = TasksService()
        
        task.taskTitle = taskTitleTextField.text!
        task.points = estimateTextField.text
        task.taskDescription = taskDescriptionTextField.text
        task.dueDate = taskDueDate.text
        task.taskStatus = phaseTextField.text!
        task.taskCategory = category
        task.taskCollaborators = self.taskCollaborator

        
        taskService.createNewTask(task: self.task, projectId: (self.storyBoard?.storyBoardId)!, onTaskCreated: { taskId in
            self.task.taskId = taskId
        })
    
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickMembers" {
            print(segue.destination.description)
            if let membersVC = segue.destination as? MembersViewController {
                membersVC.storyBoardId = self.storyBoard?.storyBoardId
                membersVC.taskCollaboratorSelectionDelegate = self
            }
        }
    
    }
    
    func onCollaboratorDelected(collaborator: ProMUser?) {
        self.collaboratorTextField.text = collaborator?.name
        self.taskCollaborator = collaborator
    }

}



