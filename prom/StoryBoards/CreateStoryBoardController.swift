//
//  CreateStoryBoardControllerTableViewController.swift
//  prom
//
//  Created by Deepak Sharma S M on 3/10/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

class CreateStoryBoardController: UITableViewController, StoryBoardsView  {
    
    func setStoryBoards(storyboards: [StoryBoard]?) {
        
    }
    
    @IBOutlet weak var storyBoardTitle: UITextField!
    
    let storyBoardPresenter = StoryBoardsPresenter(storyBoardService: StoryBoardService())
  
    override func viewDidLoad() {
        super.viewDidLoad()
        storyBoardPresenter.attachView(view: self)
    }

    @IBAction func createNewStoryBoard(_ sender: Any) {
        guard storyBoardTitle.text != nil else {
            return
        }
        self.storyBoardPresenter.createStoryBoardWith(title: storyBoardTitle.text!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
