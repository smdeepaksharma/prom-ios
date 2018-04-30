//
//  StoryBoardsViewController.swift
//  prom
//
//  Created by Deepak Sharma S M on 3/8/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit
import Firebase

class StoryBoardsViewController: UITableViewController {
    
    var storyBoardList: [StoryBoard]?
    let storyBoardPresenter = StoryBoardsPresenter(storyBoardService: StoryBoardService())
    var selectedStory: StoryBoard?

    override func viewDidLoad() {
        super.viewDidLoad()
        storyBoardPresenter.attachView(view: self)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        storyBoardPresenter.getStoryBoards()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func signOut(_ sender: Any) {
        try? Auth.auth().signOut()
        Switcher.updateRootVC()
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storyBoardList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
        cell.textLabel?.text = storyBoardList![indexPath.item].storyBoardTitle
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedStory = storyBoardList![indexPath.item]
        performSegue(withIdentifier: "storyDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "storyDetails" {
            if let destination = segue.destination as? TasksViewController {
                destination.selectedStoryBoard = self.selectedStory!
            }
        }
        
    }
    

}

extension StoryBoardsViewController: StoryBoardsView {
    func updateView() {
        
    }
    
    func setStoryBoards(storyboards: [StoryBoard]?) {
        if storyboards == nil {
            self.tableView.backgroundView = EmptyStateView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), nib: "EmptyState", image: UIImage.init(named: "storyboard")!, message: "Go ahead and create your first stoyboard")
        } else {
            self.storyBoardList = storyboards!
            self.tableView.reloadData()
        }
    }
    
    
    
    

}


