//
//  Task.swift
//  prom
//
//  Created by Deepak Sharma S M on 3/17/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

class Task: NSObject {
    
    var taskId: String?
    var taskTitle: String
    var taskDescription: String?
    var taskCategory: String
    var points: String?
    var taskOwner: ProMUser
    var taskCollaborators: ProMUser?
    var taskStatus: String
    var taskType: String?
    var dueDate: String?

    
    init(title: String, owner: ProMUser, status: String = "Unstarted", category: String = "New Ideas") {
        self.taskTitle = title
        self.taskOwner = owner
        self.taskStatus = status
        self.taskCategory = category
    }

}
