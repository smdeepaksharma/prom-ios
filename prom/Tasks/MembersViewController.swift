//
//  MembersViewController.swift
//  prom
//
//  Created by Deepak Sharma S M on 4/15/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

protocol TaskCollaboratorDelegate : NSObjectProtocol {
    func onCollaboratorDelected(collaborator: ProMUser?)
}


class MembersViewController: BaseUITableViewController {
    
    
    var storyBoardId: String?
    var projectMembers: [ProMUser]?
    
    var taskCollaborator: ProMUser?
    
    var taskCollaboratorSelectionDelegate: TaskCollaboratorDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if storyBoardId != nil {
            self.currentView = self.view
            print(storyBoardId!)
            let vc = startLoading()
            InviteService().getProjectMembers(storyBoardId: self.storyBoardId!, completionHandler: { projectMembers in
                self.projectMembers = projectMembers
                self.tableView.reloadData()
                self.stopLoading(spinner: vc)
            })
            
        }
    }

    @IBAction func OnDonePressed(_ sender: Any) {
        self.taskCollaboratorSelectionDelegate?.onCollaboratorDelected(collaborator: self.taskCollaborator)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onCancelPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.projectMembers?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.taskCollaborator = self.projectMembers?[indexPath.row]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath)
        cell.imageView?.autoresizingMask = []
        cell.imageView?.frame.size.height = 35.0
        cell.imageView?.frame.size.width = 35.0
        cell.imageView?.setImageForName(string: self.projectMembers![indexPath.row].name, backgroundColor: UIColor.darkGray, circular: true, textAttributes: nil, gradient: true)
        cell.textLabel?.text = self.projectMembers![indexPath.row].name
        return cell
    }

}
