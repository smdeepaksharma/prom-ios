//
//  InviteService.swift
//  prom
//
//  Created by Deepak Sharma S M on 4/21/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit
import SwiftyJSON

struct ProMUser {
    
    let key: String
    let email: String
    let name: String
    
}


class InviteService: FirebaseService {
    
    let storyBoardKey = StoryBoardKeys()

    func getPromUsers(onMembersFetched: @escaping (_ promUsers: [ProMUser]) -> ()) {
        
        self.getDatabaseReference().child(firebaseKey.MEMBERS_KEY).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            if value == nil {
                print("No boards yet")
            } else {
                var promUsers: [ProMUser] = []
                for (key, details) in value! {
                    let userDetails = details as! NSDictionary
                    promUsers.append(ProMUser(key: key as! String, email: userDetails["email"] as! String, name: userDetails["name"] as! String))
                }
                onMembersFetched(promUsers)
            }
        })
    }
    
    
    func addBoardSubscriber(selectedStory: StoryBoard, collaborators: [ProMUser]?) {
        if let newCollaborators = collaborators {
            for promUser in newCollaborators {
                getDatabaseReference().child(firebaseKey.STORYBOARDS_KEY)
                    .child(selectedStory.storyBoardId!).child(storyBoardKey.collaboraters).child(promUser.key)
                    .setValue(promUser.name)
                
                self.getDatabaseReference().child(firebaseKey.USER_PROJECTS_KEY)
                    .child(promUser.key).child(selectedStory.storyBoardId!).setValue(selectedStory.storyBoardTitle)
            }
         
            
        }
    }
    
    
    
    
    func getProjectMembers(storyBoardId: String, completionHandler: @escaping ([ProMUser]?) -> ()) {
        
        getDatabaseReference().child(firebaseKey.STORYBOARDS_KEY).child(storyBoardId).child(storyBoardKey.collaboraters)
        .observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                print(value)
                var projectMembers : [ProMUser] = [self.getCurrentUser()!]
                for (key, username) in value {
                    projectMembers.append(ProMUser(key: key as! String, email: "", name: username as! String))
                }
               completionHandler(projectMembers)
            } else {
                print("No collaborators")
                completionHandler(nil)
            }
        })
    }
    

    
    
    
}
