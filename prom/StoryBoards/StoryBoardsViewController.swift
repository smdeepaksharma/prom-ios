//
//  StoryBoardsViewController.swift
//  prom
//
//  Created by Deepak Sharma S M on 3/8/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

class StoryBoardsViewController: UITableViewController {
    
    var storyBoardList: [StoryBoard]?
    let storyBoardPresenter = StoryBoardsPresenter(storyBoardService: StoryBoardService())

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
        print(storyBoardList![indexPath.item].storyBoardTitle ?? "E")
        performSegue(withIdentifier: "projectTasks", sender: self)
    }
    

}

extension StoryBoardsViewController: StoryBoardsView {
    func updateView() {
        
    }
    
    func setStoryBoards(storyboards: [StoryBoard]?) {
        self.storyBoardList = storyboards!
        print("in view \(self.storyBoardList?.count)")
        self.tableView.reloadData()
    }
    
    
    
    

}


