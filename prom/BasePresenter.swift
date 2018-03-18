//
//  BasePresenter.swift
//  prom
//
//  Created by Deepak Sharma S M on 3/10/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

class BasePresenter: NSObject {
    
    weak private var view: UIViewController?
    
    func attachView(view: UIViewController) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
}
