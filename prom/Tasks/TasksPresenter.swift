//
//  TasksPresenter.swift
//  prom
//
//  Created by Deepak Sharma S M on 4/19/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

protocol TasksView : NSObjectProtocol {
    
    func updateTasksView(newIdeas: [Task]?, proritize: [Task]?, myWork: [Task]?)
    func setStoryBoard(storyBoard: StoryBoard)
    func updateUI()
    
}

class TasksPresenter  {
    
    private let taskService: TasksService
    weak private var tasksView : TasksView?
    
    init(taskService: TasksService) {
        self.taskService = taskService
    }
    
    func attachView(view: TasksView) {
        tasksView = view
    }
    
    func detachView() {
        tasksView = nil
    }
    
    func createTask(task: Task, projectId: String) {
        self.taskService.createNewTask(task: task, projectId: projectId, onTaskCreated: { taskId in
            self.tasksView?.updateUI()
        })
    }
    
    func getStoryBoardDetails(storyBoardId: String) {
        self.taskService.getStoryBoardDetails(storyBoardId: storyBoardId, completionHandler: { storyBoard in
            self.tasksView?.setStoryBoard(storyBoard: storyBoard)
        })
    }
    
    func getStoryBoardTasks(storyboardId: String) {
         self.taskService.getBoardTasks(storyboardId: storyboardId, completionHandler: { (newIdeas, proritize) in
            let myWork = self.getMyTasks(newIdeas: newIdeas, prioritize: proritize)
            self.tasksView?.updateTasksView(newIdeas: newIdeas, proritize: proritize, myWork: myWork)
        })
    }
    
    
    func getMyTasks(newIdeas: [Task]?, prioritize: [Task]?) -> [Task]? {
        var myTasks: [Task] = []
        let currentUid = self.taskService.getCurrentFBUserID()
        
        if let myTasksInNewIdeas = newIdeas {
            for task in myTasksInNewIdeas {
                if task.taskOwner.key == currentUid {
                    myTasks.append(task)
                }
                if task.taskCollaborators?.key == currentUid {
                    myTasks.append(task)
                }
            }
        }
        
        if let myTasksInPrioritize = prioritize {
            for task in myTasksInPrioritize {
                if task.taskOwner.key == currentUid {
                    myTasks.append(task)
                }
                if task.taskCollaborators?.key == currentUid {
                    myTasks.append(task)
                }
            }
        }
        
        if myTasks.isEmpty {
            return nil
        }
        return myTasks
    }
    
}
