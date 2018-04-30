//
//  SignUpViewController.swift
//  prom
//
//  Created by Deepak Sharma S M on 3/4/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

class SignUpViewController: UITableViewController {
    
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    let authPresenter = AuthPresenter(authService: AuthService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        authPresenter.attachView(view: self)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func onSignUpCancelled(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
   
    @IBAction func onSignUpClicked(_ sender: UIButton) {
        guard email.text != nil && !(email.text?.isEmpty)! else {
            showError(title: "Required", message: "Please enter email address")
            return
        }
        
        guard password.text != nil && !(password.text?.isEmpty)! else {
            showError(title: "Required", message: "Please enter your password")
            return
        }
        
        guard isValidEmail(testStr: email.text!) == true else {
            showError(title: "Invalid", message: "Please enter a valid email address")
            return
         }
        
        authPresenter.signUpWith(email: email.text!, password: password.text!, fullname: fullname.text!)
     }
    

    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    

}

extension SignUpViewController: AuthView {
        func updateUI() {
            performSegue(withIdentifier: "redirectToMain", sender: self)
        }
        
        func startLoading() -> UIView {
            let uiView = self.view!
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
        
        func showError(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
}

