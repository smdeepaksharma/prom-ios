//
//  Project.swift
//  prom
//
//  Created by Deepak Sharma S M on 3/17/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

class StoryBoard: NSObject {
    
    var storyBoardId: NSNumber?
    var storyBoardTitle: NSString?
    var owner: NSString?
    var collaborators: NSDictionary?
    var inProgressTasks: NSDictionary?
    var doneTasks: NSDictionary?
    var iceBoxTasks: NSDictionary?
    
    init(projectID: NSNumber, projectTitle: NSString, owner: NSString) {
        self.storyBoardId = projectID
        self.storyBoardTitle = projectTitle
        self.owner = owner
    }

}
