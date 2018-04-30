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
    var title: String = "title"
    var description: String = "description"
    var status: String = "status"
    var owner: String = "owner"
    var dueDate: String = "due"
    var collaborator: String = "collaborator"
    var points: String = "points"
    var newIdeas: String = "New Ideas"
    var prioritize: String = "Prioritize"
}

class TasksService: FirebaseService {

    let taskKey = TaskKeys()
    let storyBoardKeys = StoryBoardKeys()
    
    func createNewTask(task: Task, projectId: String, onTaskCreated: @escaping (_ taskId: String) -> ()) {
        
        var taskData: [String : Any] = [
            taskKey.title : task.taskTitle,
            taskKey.owner : [task.taskOwner.key: task.taskOwner.name],
            taskKey.status: task.taskStatus]
        if let description = task.taskDescription {
            taskData[taskKey.description] = description
        }
        
        if let collaborator = task.taskCollaborators {
            taskData[taskKey.collaborator] = [collaborator.key: collaborator.name]
        }
        
        if let dueDate = task.dueDate {
            taskData[taskKey.dueDate] = dueDate
        }
        
        if let points = task.points {
            taskData[taskKey.points] = points
        }
        
        if task.taskId == nil {
            task.taskId = self.getDatabaseReference().child(firebaseKey.TASKS_KEY).childByAutoId().key
        }
        
        self.getDatabaseReference().child("/\(firebaseKey.TASKS_KEY)/\(projectId)/\(task.taskCategory)/\(task.taskId!)").setValue(taskData)
        
        onTaskCreated(task.taskId!)
        
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
    
    
    func getBoardTasks(storyboardId: String, completionHandler: @escaping (_ newIdeas: [Task]?, _ prioritize: [Task]?) -> ()) {
        
        getDatabaseReference().child(firebaseKey.TASKS_KEY).child(storyboardId).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let tasks = snapshot.value as? NSDictionary {
                var newIdeasArray: [Task] = []
                var proritizedTasksArray: [Task] = []
                
                if let newIdeas = tasks.value(forKey: self.taskKey.newIdeas) as? NSDictionary {
                    for (taskKey, details) in newIdeas {
                        if let taskDetails = details as? NSDictionary {
                            newIdeasArray.append(self.getTaskProtocolFor(taskDetails: taskDetails, key: taskKey as! String))
                        }
                    }
                }
                
                if let prioritize = tasks.value(forKey: self.taskKey.prioritize) as? NSDictionary {
                    for (taskKey, details) in prioritize {
                        if let taskDetails = details as? NSDictionary {
                            proritizedTasksArray.append(self.getTaskProtocolFor(taskDetails: taskDetails, key: taskKey as! String))
                        }
                    }
                }
                completionHandler(newIdeasArray, proritizedTasksArray)
            } else {
                completionHandler(nil, nil)
            }
       })
    }
    
    func getTaskProtocolFor(taskDetails: NSDictionary, key: String) -> Task {
        
        var taskOwner: ProMUser?
        var taskCollaborator: ProMUser?
        
        if let owner = taskDetails["owner"] as? NSDictionary {
            for (key, name) in owner {
                taskOwner = ProMUser(key: key as! String, email: "", name: name as! String)
            }
        }
        
        if let collaborator = taskDetails["collaborator"] as? NSDictionary {
            for (key, name) in collaborator {
                taskCollaborator = ProMUser(key: key as! String, email: "", name: name as! String)
            }
        }
        
        let task =  Task(title: taskDetails["title"] as! String, owner: taskOwner!)
        task.points = taskDetails.value(forKey: "points") as? String
        task.taskDescription = taskDetails.value(forKey: "description") as? String
        task.taskStatus = (taskDetails.value(forKey: "status") as? String)!
        task.dueDate = taskDetails.value(forKey: "due") as? String
        task.taskId = key
        
        if let collaborator = taskCollaborator {
            task.taskCollaborators = collaborator
        }
        
        return task
    }
    
    func getStoryBoardDetails(storyBoardId: String, completionHandler: @escaping (_ storyBoard: StoryBoard) -> ()) {
        getDatabaseReference().child(firebaseKey.STORYBOARDS_KEY).child(storyBoardId).observeSingleEvent(of: .value, with: { (snapshot) in
        
            if let value = snapshot.value as? NSDictionary {
                
                var boardOwner: ProMUser?
                var collaborators: [ProMUser] = []
                
                if let owner = value["owner"] as? NSDictionary {
                    for (key, name) in owner {
                        boardOwner = ProMUser(key: key as! String, email: "", name: name as! String)
                    }
                }
                
                if let collaborator = value["collaborator"] as? NSDictionary {
                    for (key, name) in collaborator {
                        collaborators.append(ProMUser(key: key as! String, email: "", name: name as! String))
                    }
                }
                
                let storyBoard = StoryBoard(projectID: storyBoardId, projectTitle: value.value(forKey: self.storyBoardKeys.title) as! String, owner: boardOwner!)
                
                storyBoard.collaborators = value.value(forKey: self.storyBoardKeys.collaboraters) as? NSDictionary
                completionHandler(storyBoard)
            }
        })
    }
    
}
