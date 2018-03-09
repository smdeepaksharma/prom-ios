//
//  AuthViewController.swift
//  prom
//
//  Created by Deepak Sharma S M on 2/22/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

class AuthViewController: UITableViewController {

    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    

    let authPresenter = AuthPresenter(authService: AuthService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStylesToBtn()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        authPresenter.attachView(view: self)
    }
    
    @IBAction func onSignInCancelled(_ sender: Any) {
        print("Cancel clicked")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func onSignInClicked(_ sender: UIButton) {
        self.view.endEditing(true)
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
        
        authPresenter.signInWith(email: email.text!, password: password.text!)
        
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

    
    func addStylesToBtn() {
        signInBtn.backgroundColor = .clear
        signInBtn.layer.cornerRadius = 6
        signInBtn.layer.borderWidth = 1
        signInBtn.layer.borderColor = UIColor.gray.cgColor
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AuthViewController: AuthView {
    func updateUI(user: AuthViewData) {
        
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

extension UIViewController {
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}



