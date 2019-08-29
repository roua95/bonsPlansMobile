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
import PKHUD
import FBSDKLoginKit
import GoogleSignIn

class sign_upViewController: UIViewController, UITextFieldDelegate , GIDSignInUIDelegate, GIDSignInDelegate {
    @IBOutlet weak var google: UIButton!
    
    
    @IBOutlet weak var nom: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var emailField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var prenom: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var password: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var confirmPassword: SkyFloatingLabelTextFieldWithIcon!
    
    
    @IBOutlet weak var facebook: UIButton!
    
    var emailText: String?
    var firstNameText: String?
    var lastNameText: String?
    var passwordText: String?
    var confirmPasswordText: String?
    var fbManager : FBSDKLoginManager!
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
           // let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            let provider = "google"
            WebServiceBP.sharedInstance().signInSocialMedia(email!, provider: provider, provider_id: userId!)
            { (isTrue) in
                if isTrue{
                    print("success sign up with social media")
                }
                else {print("failure sign up with social media")
                    
            print("GOOGLE ", userId, idToken)
        }
    }
        }
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func google(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signOut()
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func facebook(_ sender: Any) {
        
        fbManager.logOut()
        fbManager.loginBehavior = .native
        fbManager.logIn(withReadPermissions: ["public_profile","email"], from: self) { (result, err) in
            HUD.show(.progress)
            if err != nil {
                HUD.hide()
                //    print("Custom FB Login failed:", err)
                return
            }
            self.returnData()
            HUD.hide()
        }
    }
    
    func returnData(){
        
        if ((FBSDKAccessToken.current()) != nil)
        {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, first_name , last_name, email, gender, link, picture.type(large), age_range"])
        graphRequest.start { (connection, result, error) in
            
            if(error != nil)
            {
                print("\(error!.localizedDescription)")
                return
            }
            
            if(result != nil)
            {
                guard let fbData = result as? [String:Any] else { return }
                
                let userId = fbData["id"] as! String
                let userFirstName = fbData["first_name"] as! String
                let userLastName = fbData["last_name"] as! String
                let userEmail = fbData["email"] as? String
                
                print("\(userEmail)")
                
                let myUser:FbUser = FbUser.init(userId: Int(userId)! , userFirstName: userFirstName, userLastName: userLastName, userEmail: userEmail ?? "\(userFirstName)@gmail.com")
                
                // Save first name
                if(userFirstName != nil)
                {
                    myUser.set(userFirstName, forKey: "first_name")
                    
                }
                
                //Save last name
                if(userLastName != nil)
                {
                    myUser.set(userLastName, forKey: "last_name")
                }
                
                // Save email address
                if(userEmail != nil)
                {
                    myUser.set(userEmail, forKey: "email")
                }
                
            }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        emailField.delegate = self
        nom.delegate = self
        prenom.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        
        fbManager = FBSDKLoginManager()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)    }
    @IBAction func confirmPassword(_ sender: Any) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    //action related to sign up button
    
    @IBAction func signUpActionBtn(_ sender: Any) {
        
        
        //validate firstName
        if nom.text == "" {
            nom.errorMessage = "champs obligatoire"
        }else{
            nom.errorMessage = ""
        }
        
        //validate lastName
        
        if prenom.text == "" {
            prenom.errorMessage = "champs obligatoire"
        }else{
            prenom.errorMessage = ""
        }
        
        //validate email
        
        if (emailField.text != "" && validateEmail(enteredEmail: emailField?.text ?? "hee")){
            emailField.errorMessage = ""
        }
        else {emailField.errorMessage = "email invalide"}
        //validate password
        
        if password.text == ""{ password.errorMessage = "Champs obligatoire"
        }
        else if((password.text?.count ?? 0) < 6)
        {
            password.errorMessage = "mot de passe très court"
        }
        else {password.errorMessage = ""}
        
        
        //validate confirmpassword
        
        if confirmPassword.text == password.text
        {
            confirmPassword.errorMessage = ""
        }
        else {confirmPassword.errorMessage = " non conforme avec le mot de passe "}
        
        if (nom.text != "" && prenom.text != "" && password.text != "" && confirmPassword.text != "" && emailField.text != "" ){
            
            WebServiceBP.sharedInstance().signUp(prenom :prenom.text!,nom : nom.text!,emailField.text!, password: password.text!,confirmPassword: confirmPassword.text!) { (isTrue) in
               
                if isTrue{
                    print("success sign up with mail")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "UITabBarViewController"
                        ) as! UITabBarViewController
                    let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController"
                        ) as! ProfileViewController
                    let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "AjoutPlanViewController"
                        ) as! AjoutPlanViewController
                    let vc3 = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController"
                        ) as! DashboardViewController
                    let vc4 = self.storyboard?.instantiateViewController(withIdentifier: "PlusViewController"
                        ) as! PlusViewController
                    
                    let vc5 = self.storyboard?.instantiateViewController(withIdentifier: "EmptyFavoriteViewController"
                        ) as! EmptyFavoriteViewController
                    let controllers = [vc1, vc5, vc3, vc4, vc2]
                    
                    vc.viewControllers = controllers
                    vc.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else {print("failure sign up with mail")
           
                }
            }
        }
        // making the translation between interfaces
        //        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //
        //        let SecondViewController = storyBoard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        //        SecondViewController.emaillabelText = emailText!
        //
        //        self.navigationController?.pushViewController(SecondViewController, animated: true)
        //    }
        
        
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func addLeftImageTo(txtField: UITextField, andImage img: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
        leftImageView.image = img
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
    }
}
