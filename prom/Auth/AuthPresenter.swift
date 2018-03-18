//
//  AuthPresenter.swift
//  prom
//
//  Created by Deepak Sharma S M on 2/22/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

struct AuthViewData {
    var email: String
    var password: String
    var fullname: String
}

protocol AuthView: NSObjectProtocol {
    func startLoading() -> UIView
    func stopLoading(spinner: UIView)
    func showError(title: String, message: String)
    func updateUI(user: AuthViewData)
}

class AuthPresenter: NSObject {
    private let authService: AuthService
    weak private var authView: AuthView?
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func attachView(view: AuthView) {
        authView = view
    }
    
    func detachView() {
        authView = nil
    }
    
    func signInWith(email: String, password: String) {
        let sv = self.authView?.startLoading()
        authService.signInWith(email: email, password: password, onSuccess : { user in
            print(user)
            self.authView?.stopLoading(spinner: sv!)
        }, onFailure: { errorMessage in
            self.authView?.stopLoading(spinner: sv!)
            self.authView?.showError(title: "Invalid Email/Password", message: errorMessage)
        })
    }
    
    func numberOfRowsForSignUpUI() -> Int {
        return 3
    }
    
    func numberOfRowsForSignInUI() -> Int {
        return 2
    }
    
    func signUpWith(email: String, password: String, fullname: String) {
        let activityIndicator = self.authView?.startLoading()
        authService.signUpWith(email: email, password: password, fullname: fullname, successCallBack: { user in
            self.authView?.stopLoading(spinner: activityIndicator!)
        }, failureCallBack: { error in
             self.authView?.stopLoading(spinner: activityIndicator!)
        });
    }
    
}
