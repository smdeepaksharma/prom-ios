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

    let firebaseKey = FirebaseKey()
    var storyBoardsKey = StoryBoardKeys()
    
    func getStoryBoards(onStoryBoardsFetched: (_ boardsList: [String]?) -> Void )  {
        if let userId = getCurrentFBUserID() {
            self.getDatabaseReference().child(firebaseKey.USER_PROJECTS_KEY).child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                if value == nil {
                    print("No boards yet")
                } else {
                    print(value!)
                }
            })
        }
    }
    
    func createStoryBoardWith(title: String) {
        if let userId = getCurrentFBUserID() {
            let timestamp = NSDate().timeIntervalSince1970
            let storyKey = "\(userId)\(timestamp)"
            self.getDatabaseReference().child(firebaseKey.STORYBOARDS_KEY)
                .child(storyKey)
                .setValue([storyBoardsKey.title: title, storyBoardsKey.owner: userId])
        }
    }
    
    func addCollaboraters(collaboraterIds: [NSString], projectId: String) {
        self.getDatabaseReference().child(projectId).child(storyBoardsKey.collaboraters).setValue(collaboraterIds)
    }

}
