//
//  ViewController.swift
//  bon_plan
//
//  Created by DEVLOPER on 13/02/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit
import Alamofire
import ValidationComponents

class sign_upViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!

    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    var emailText: String?
    var firstNameText: String?
    var lastNameText: String?
    var passwordText: String?
    var confirmPasswordText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        emailField.delegate = self

        
        firstNameText = firstName.text
        lastNameText = lastName.text
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //email actions (related methods)
    @IBAction func emailEdited(_ sender: Any) {
        emailText = emailField.text
        
    }
    
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    

    
    //action related to sign up button
    
    @IBAction func btnSingupAction(_ sender: Any) {
        //var emailField: String = self.emailField.text!
        print("firstname " + firstName.text! )
        print("lastname " + lastName.text!)
        print("email " + emailField.text!)

        // validation method for all text fields
        
        
        
        // making the translation between interfaces
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let SecondViewController = storyBoard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        SecondViewController.emaillabelText = emailText!
        
        self.navigationController?.pushViewController(SecondViewController, animated: true)
    }
    
    // what is this ????
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
        return true
    }

}


