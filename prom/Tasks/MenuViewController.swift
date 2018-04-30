//
//  MenuViewController.swift
//  prom
//
//  Created by Deepak Sharma S M on 4/15/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit
import InitialsImageView
import Firebase

class MenuViewController: UITableViewController, InviteMemberDelegate {
  
    @IBOutlet weak var addMemberButton: UIButton!
    @IBOutlet weak var avatarsView: UICollectionView!
    var members : [ProMUser]?
    
    var selectedStory: StoryBoard?

    @IBAction func onAddMembers(_ sender: Any) {
        performSegue(withIdentifier: "addMembers", sender: self)
    }
    
    @IBAction func onMenuClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        self.avatarsView.delegate = self
        self.avatarsView.dataSource = self
        
        self.avatarsView.register(UINib(nibName: "AvatarCell", bundle: nil), forCellWithReuseIdentifier: "avatarCell")
        
        addMemberButton.backgroundColor = .clear
        addMemberButton.layer.cornerRadius = 6
        addMemberButton.layer.borderWidth = 1
        addMemberButton.layer.borderColor = UIColor.gray.cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.members?.removeAll()
        fetchProjectMembers()
    }
    

    func fetchProjectMembers() {
        InviteService().getProjectMembers(storyBoardId: (self.selectedStory?.storyBoardId!)!, completionHandler: { projectMembers in
            if projectMembers != nil {
                self.members = projectMembers
                self.avatarsView.reloadData()
            }
        })
        
    }
    
    func onMemberSelected(collaborators: [ProMUser]?) {
        if let c = collaborators {
            InviteService().addBoardSubscriber(selectedStory: self.selectedStory!, collaborators: c)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addMembers" {
            if let inviteVC = segue.destination as? InviteMember {
                inviteVC.inviteDelegate = self
            }
        }
    }
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell",for: indexPath) as! AvatarCell
        cell.avatarImage.setImageForName(string: self.members![indexPath.row].name, backgroundColor: UIColor.gray, circular: true, textAttributes: nil, gradient: true)
        cell.nameLabel.text = self.members?[indexPath.row].name
        return cell
    }
}
