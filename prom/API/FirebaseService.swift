//
//  FirebaseService.swift
//  prom
//
//  Created by Deepak Sharma S M on 3/17/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit
import Firebase

class FirebaseService {
    
    var ref: DatabaseReference!
    let firebaseKey = FirebaseKey()
    
    func getCurrentFBUserID() -> String? {
        var userId: String? = nil
        if let user = Auth.auth().currentUser {
            userId = user.uid
        }
        return userId
    }
    
    func getDatabaseReference() -> DatabaseReference {
        return Database.database().reference();
    }
}

struct FirebaseKey {
    var USER_PROJECTS_KEY: String = "user_projects"
    var STORYBOARDS_KEY: String = "storyboards"
    var TASKS_KEY: String = "tasks"
    var MEMBERS_KEY: String = "members"
    var TASKS_IN_PROGRESS_KEY: String = "tasks_in_progress"
    var TASKS_DONE_KEY: String = "tasks_done"
    var TASKS_ICEBOX_KEY: String = "tasks_icebox"
}
