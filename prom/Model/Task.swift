//
//  Task.swift
//  prom
//
//  Created by Deepak Sharma S M on 3/17/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

class Task: NSObject {
    
    var taskId: NSString
    var taskTitle: NSString
    var taskDescription: NSString?
    var taskCategory: NSString?
    var points: NSString?
    var taskOwner: NSString
    var taskCollaborators: [NSString]?
    var taskStatus: NSString
    var taskType: NSString?
    
    init(taskId: NSString, title: NSString, owner: NSString, status: NSString = "Unstarted") {
        self.taskId = taskId
        self.taskTitle = title
        self.taskOwner = owner
        self.taskStatus = status
    }

}
