//
//  StoryBoardsPresenter.swift
//  prom
//
//  Created by Deepak Sharma S M on 3/8/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

protocol StoryBoardsView : NSObjectProtocol {
    func setStoryBoards(storyboards: [StoryBoard]?)
}

class StoryBoardsPresenter: NSObject {
    
    private let storyBoardService: StoryBoardService
    weak private var storyBoardView : StoryBoardsView?
    
    init(storyBoardService: StoryBoardService) {
        self.storyBoardService = storyBoardService
    }
    
    func getStoryBoards() {
        self.storyBoardService.getStoryBoards(onStoryBoardsFetched: { boards in
            print("presenter", boards ?? "nil")
            self.storyBoardView?.setStoryBoards(storyboards: boards!)
           })
    }
    
    func createStoryBoardWith(title: String) {
        storyBoardService.createStoryBoardWith(title: title, completionHandler: { print("success")})
    }
    
    func attachView(view: StoryBoardsView) {
        storyBoardView = view
    }
    
    func detachView() {
        storyBoardView = nil
    }

}
