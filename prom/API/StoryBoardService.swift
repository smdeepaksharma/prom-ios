//
//  StoryBoardService.swift
//  prom
//
//  Created by Deepak Sharma S M on 3/8/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit
import Firebase

struct StoryBoardKeys {
    var title: String = "title"
    var owner: String = "owner"
    var collaboraters: String = "collaboraters"
    var inProgress: String = "in_progress"
    var done: String = "done"
}

class StoryBoardService: FirebaseService {

    var storyBoardsKey = StoryBoardKeys()
    
    func getStoryBoards(onStoryBoardsFetched: @escaping (_ boardsList: [StoryBoard]?) -> Void )  {
        
        var boards: [StoryBoard]?
        if let currentUser = getCurrentUser() {
            self.getDatabaseReference().child(firebaseKey.USER_PROJECTS_KEY).child(currentUser.key).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                if value == nil {
                    print("No boards yet")
                    onStoryBoardsFetched(nil)
                } else {
                    boards = []
                    for (key, value) in value! {
                        print(key, value)
                        boards?.append(StoryBoard.init(projectID: key as! String, projectTitle: value as! String, owner: currentUser))
                        
                    }
                    onStoryBoardsFetched(boards)
                }
            })
        }
    }
    
    func createStoryBoardWith(storyBoardDetails: StoryBoard, collaborators: [ProMUser]?, completionHandler: () -> ()) {
        if let userId = getCurrentFBUserID() {
            let timestamp = NSDate().timeIntervalSince1970.bitPattern
            let storyKey = "\(userId)_\(timestamp)"
            
            let params: [String : Any] = [
                storyBoardsKey.title : storyBoardDetails.storyBoardTitle,
                storyBoardsKey.owner : [storyBoardDetails.owner.key: storyBoardDetails.owner.name]
            ]
            
            self.getDatabaseReference().child(firebaseKey.STORYBOARDS_KEY)
                .child(storyKey)
                .setValue(params)
            
            if let members = collaborators {
                var paramters : [String: String] = [:]
                for collaborator in members {
                    paramters[collaborator.key] = collaborator.name
                }
                
                getDatabaseReference().child(firebaseKey.STORYBOARDS_KEY).child(storyKey).child(storyBoardsKey.collaboraters).setValue(paramters)
                
                
                // update user_projects
                
                getDatabaseReference().child(firebaseKey.USER_PROJECTS_KEY).child(storyBoardDetails.owner.key)
                    .child(storyKey).setValue(storyBoardDetails.storyBoardTitle)
                
                for collaborator in members {
                    self.getDatabaseReference().child(firebaseKey.USER_PROJECTS_KEY)
                        .child(collaborator.key).child(storyKey).setValue(storyBoardDetails.storyBoardTitle)
                }
            }
            
           
            
            
             completionHandler()
        }
    }
    
    func addCollaboraters(collaboraterIds: [NSString], projectId: String) {
        self.getDatabaseReference().child(projectId).child(storyBoardsKey.collaboraters).setValue(collaboraterIds)
    }

}
