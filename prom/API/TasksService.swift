//
//  TasksService.swift
//  prom
//
//  Created by Deepak Sharma S M on 3/17/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit
import Firebase

struct TaskKeys {
    var title: String = "task"
    var description: String = "description"
    var status: String = "task"
    var owner: String = "owner"
    var collaborator: String = "collaborator"
    var points: String = "points"
}

class TasksService: FirebaseService {

    let taskKey = TaskKeys()
    
    func createNewTask(task: Task, projectId: String) {
        var taskData = [
            taskKey.title : task.taskTitle,
            taskKey.owner : task.taskOwner,
            taskKey.status: task.taskStatus]
        if let description = task.taskDescription {
            taskData[taskKey.description] = description
        }
        if let points = task.points {
            taskData[taskKey.points] = points
        }
        let taskId = self.getDatabaseReference().child(firebaseKey.TASKS_KEY).childByAutoId().key
        self.getDatabaseReference().child("/\(firebaseKey.TASKS_KEY)/\(taskId)").setValue(taskData)
    }
    
    func updateTaskDetailWith(key: String, taskId: String, value: String) {
        let updatePath = "/\(firebaseKey.TASKS_KEY)/\(taskId)/\(key)"
        self.getDatabaseReference().child(updatePath).setValue(value)
    }
    
    func updateTaskDescription(taskId: String, description: String) {
       updateTaskDetailWith(key: taskKey.description, taskId: taskId, value: description)
    }
    
    func addCollaborator(taskId: String, collaboratorId: String) {
        updateTaskDetailWith(key: taskKey.collaborator, taskId: taskId, value: collaboratorId)
    }
    
    func updateStatus(taskId: String, status: String) {
        updateTaskDetailWith(key: taskKey.status, taskId: taskId, value: status)
    }
    
    func updateTaskPoints(taskId: String, points: String) {
        updateTaskDetailWith(key: taskKey.points, taskId: taskId, value: points)
    }
    
}
