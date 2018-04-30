//
//  InviteMember.swift
//  prom
//
//  Created by Deepak Sharma S M on 4/21/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit
import InitialsImageView

protocol InviteMemberDelegate {
    func onMemberSelected(collaborators: [ProMUser]?)
}


class InviteMember: BaseUITableViewController {

    @IBOutlet weak var memberEmailTextField: UITextField!
    
    var inviteDelegate: InviteMemberDelegate?
    
    let inviteService = InviteService()
    var promUsers: [ProMUser]?
    var selectedBoard: StoryBoard?
    var selectedCollaborators: [ProMUser]?
    var nullStateView: EmptyStateView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Invite Member"
        self.currentView = self.view
        self.nullStateView = EmptyStateView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), nib: "EmptyState", image: UIImage.init(named: "add_user")!, message : "Add members")
        
        self.inviteService.getPromUsers(onMembersFetched: {promUsers in
            self.promUsers = promUsers
            
            if self.promUsers == nil {
                self.tableView.backgroundView = self.nullStateView
            } else {
                self.tableView.reloadData()
            }
        })
        self.selectedCollaborators = []
  
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onInviteCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func onAddCollaborators(_ sender: Any) {
        if self.inviteDelegate != nil {
            self.inviteDelegate?.onMemberSelected(collaborators: self.selectedCollaborators)
            self.navigationController?.popViewController(animated: true)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.promUsers?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMember = self.promUsers![indexPath.row]
        print(selectedMember.name)
        self.selectedCollaborators?.append(selectedMember)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath)
        cell.imageView?.autoresizingMask = []
        cell.imageView?.frame.size.height = 35.0
        cell.imageView?.frame.size.width = 35.0
        cell.imageView?.setImageForName(string: self.promUsers![indexPath.row].name, backgroundColor: UIColor.darkGray, circular: true, textAttributes: nil, gradient: true)
        cell.textLabel?.text = self.promUsers![indexPath.row].name
        return cell
    }
}
