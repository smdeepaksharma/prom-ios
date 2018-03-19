//
//  CommonUIView.swift
//  prom
//
//  Created by Deepak Sharma S M on 3/18/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//
import UIKit

class CommonUIView {
    
    let currentView: UIView? = nil
    
    func startLoading() -> UIView {
        let uiView = currentView!
        let spinnerView = UIView.init(frame: uiView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.9)
        let activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            uiView.addSubview(spinnerView)
        }
        return spinnerView
    }
    
    func stopLoading(spinner: UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
    
    func showError(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    func showErrorWith(title: String, message: String, vc: UITableViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
