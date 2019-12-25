//
//  ViewController.swift
//  Collabgram
//
//  Created by Dinaol Melak on 12/24/19.
//  Copyright © 2019 Dinaol Melak. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController {

    let custom = Customfunctions()
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onTapSignIn(_ sender: Any) {
        if usernameTextField.text == "" || passwordTextField.text == "" {
            custom.showAlert(title: "Empty", message: "Please Check Text Field and Try Again")
        } else{
            PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (success, error) in
                if error != nil{
                    print("oops!, \(String(describing: error))")
                }else{
                    print("Success Signing In!")
                    self.performSegue(withIdentifier: "LoggedIn", sender: self)
                }
            }
        }
        
    }
    @IBAction func onTapSignUp(_ sender: Any) {
        if usernameTextField.text == "" || passwordTextField.text == ""{
            custom.showAlert(title: "Empty", message: "Please Check Text Field and Try Again")
        } else{
            let user = PFUser()
            user.username = usernameTextField.text!
            user.password = passwordTextField.text!
            
            user.signUpInBackground { (success, error) in
                if error != nil{
                    print("oops!, \(String(describing: error))")
                }else{
                    print("Success Signing UP!")
                    self.performSegue(withIdentifier: "LoggedIn", sender: self)
                }
            }
            
        }
        
    }
    
    
}

