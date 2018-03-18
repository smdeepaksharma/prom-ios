//
//  SpinnerView.swift
//  prom
//
//  Created by Deepak Sharma S M on 3/10/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

class SpinnerView: UIViewController {
    
    static func startLoading(parentView: UIView) -> UIView {
        let uiView = parentView
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
    
    static func stopLoading(spinner: UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
