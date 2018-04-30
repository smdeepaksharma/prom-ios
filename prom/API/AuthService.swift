//
//  AuthService.swift
//  prom
//
//  Created by Deepak Sharma S M on 2/22/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit
import Firebase

class AuthService: NSObject {
    
     var ref: DatabaseReference!
    
    func signInWith(email: String, password: String,
                    onSuccess successCallback: @escaping (_ user: User) -> Void,
                    onFailure failureCallback: @escaping (_ errorMessage: String) -> Void)
    {
        Auth.auth().signInAndRetrieveData(withEmail: email, password: password) { (user, error) in
            if let err = error {
                print(err)
                failureCallback("The email/password you entered is incorrect")
            } else {
                print(user?.user.email ?? "user")
                successCallback((user?.user)!)
            }
        }
    }
    
    
    func signUpWith(email: String, password: String, fullname: String,
                    successCallBack: @escaping (_ user: User) -> Void,
                    failureCallBack: @escaping (_ errorMessage: String) -> Void ) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                let profileUpdateRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                profileUpdateRequest?.displayName = fullname
                
                profileUpdateRequest?.commitChanges { (profileerror) in
                    if error == nil {
                        self.updateMembersList()
                        successCallBack(user!)
                    } else {
                        failureCallBack(profileerror.debugDescription)
                    }
                }
            } else {
                failureCallBack(error.debugDescription)
            }
        }
    
    }
    
    
    func updateMembersList() {
        if let user = Auth.auth().currentUser {
            ref = Database.database().reference()
            self.ref.child("members").child(user.uid).setValue(["email" : user.email!, "name" : user.displayName!])
        }
    }
    
    func generateUserInitails(username: String) -> String {
        var name = username.split(separator: " ")
        let secondChar = name.count > 1 ? name[1].first : nil
        if secondChar != nil {
            return "\(String(describing: name[0].first!))\(secondChar!)"
        } else {
            return "\(String(describing: name[0].first!))"
        }
    }
}
