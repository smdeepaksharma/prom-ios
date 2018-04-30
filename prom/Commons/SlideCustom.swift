//
//  SlideCustom.swift
//  prom
//
//  Created by Deepak Sharma S M on 4/30/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit
import SideMenu

class SlideCustom: UISideMenuNavigationController {

    override func viewDidLoad() {
        // Define the menus
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: self)
       
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }

}
