//
//  Switcher.swift
//  prom
//
//  Created by Deepak Sharma S M on 4/29/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Switcher {
    
    static func updateRootVC(){
        
        let status = Auth.auth().currentUser != nil
        var rootVC : UIViewController?
        
        print(status)
        
    
        if(status == true){
            let storyBoardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StoryBoardsViewController") as! StoryBoardsViewController
            let navigationVC: UINavigationController =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainNavigation") as! UINavigationController
                        navigationVC.setViewControllers([storyBoardVC], animated: true)
            rootVC = navigationVC
            
        }else{
            let featureVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeatureIntroVC") as! FeatureViewController
            let featureNVC: UINavigationController =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeatureNavigation") as! UINavigationController
            featureNVC.setViewControllers([featureVC], animated: true)
            rootVC = featureNVC
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
    
}
