//
//  CreateStoryBoardControllerTableViewController.swift
//  prom
//
//  Created by Deepak Sharma S M on 3/10/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit
import InitialsImageView
import Firebase

class CreateStoryBoardController: BaseUITableViewController, StoryBoardsView, InviteMemberDelegate  {
    
    var members: [String] = []
    var collaborators : [ProMUser]?
    @IBOutlet weak var teamMembersView: UICollectionView!
    @IBOutlet weak var storyBoardTitle: UITextField!
    let storyBoardPresenter = StoryBoardsPresenter(storyBoardService: StoryBoardService())
    var boardOwner: ProMUser?
    
    func updateView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.teamMembersView.reloadData()
    }
    
    
    func setStoryBoards(storyboards: [StoryBoard]?) {
        
    }
    
    func onMemberSelected(collaborators: [ProMUser]?) {
        if let c = collaborators {
            for mem in c {
                self.members.append(mem.name)
            }
            self.teamMembersView.reloadData()
        }
        self.collaborators = collaborators
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        storyBoardPresenter.attachView(view: self)
        self.teamMembersView.delegate = self
        self.teamMembersView.dataSource = self
        
        self.teamMembersView.register(UINib(nibName: "AvatarCell", bundle: nil), forCellWithReuseIdentifier: "avatarCell")
        
        if let owner = Auth.auth().currentUser?.displayName {
            members.append(owner)
        }
        
        boardOwner = FirebaseService().getCurrentUser()
        
        
    }

    @IBAction func createNewStoryBoard(_ sender: Any) {
        guard storyBoardTitle.text != nil && !(storyBoardTitle.text?.isEmpty)! else {
            showError(title: "Required", message: "Storyboard name cant be empty", vc: self)
            return
        }
        
        guard boardOwner != nil else {
            showError(title: "Oops", message: "Something went wrong", vc: self)
            return
        }
        
        let storyBoard = StoryBoard.init(projectID: "", projectTitle: storyBoardTitle.text!, owner: boardOwner!)
        
        
        self.storyBoardPresenter.createStoryBoardWith(storyBoardDetails: storyBoard, collaborators: self.collaborators)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if(members.count > 0) {
                return 2
            } else {
                return 1
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "inviteMember", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inviteMember" {
            if let destinationVC = segue.destination as? InviteMember {
                destinationVC.inviteDelegate = self
            }
        }
    }
}


extension CreateStoryBoardController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell",for: indexPath) as! AvatarCell
        
        cell.avatarImage.setImageForName(string: members[indexPath.row], backgroundColor: UIColor.darkGray, circular: true, textAttributes: nil)
        cell.nameLabel.text = self.members[indexPath.row]
        return cell
        
    }

}






