//
//  StoryBoardsPresenter.swift
//  prom
//
//  Created by Deepak Sharma S M on 3/8/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

class StoryBoardsPresenter: NSObject {
    
    private let storyBoardService: StoryBoardService
    weak private var storyBoardView : StoryBoardsView?
    
    init(storyBoardService: StoryBoardService) {
        self.storyBoardService = storyBoardService
    }
    
    func getStoryBoards() {
        
    }
    
    func attachView(view: StoryBoardsView) {
        storyBoardView = view
    }
    
    func detachView() {
        storyBoardView = nil
    }

}
