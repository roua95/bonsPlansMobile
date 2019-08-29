//
//  sign-inViewController.swift
//  bon_plan
//
//  Created by DEVLOPER on 15/02/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

class sign_inViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate, FBSDKLoginButtonDelegate, UITextFieldDelegate{
    

    @IBOutlet weak var googleBtn : GIDSignInButton!
    @IBOutlet weak var facebookBtn: FBSDKLoginButton!
    @IBOutlet weak var passwordForgotten: UIButtonX!
    @IBOutlet weak var inscrire: UIButton!
    @IBOutlet weak var connexion: UIButtonX!
    @IBOutlet weak var email: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var password: SkyFloatingLabelTextFieldWithIcon!
    
    //@IBOutlet weak var emailErrorMessage: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
       // setupView()
        self.navigationController?.isNavigationBarHidden = true
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self

        email.delegate = self
        password.delegate = self
        
    }
    @IBAction func inscrire(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "sign_upViewController") as! sign_upViewController
        self.present(nextViewController, animated:true, completion:nil)

    }
    
//    fileprivate func setupView() {
//        // Configure Password Validation Label
//        passwordErrorMessage.isHidden = true
//        emailErrorMessage.isHidden = true
//
//    }
    @IBAction func BtnPressed(_ sender: Any) {
        facebookBtn.isSelected = true

    }
    
   
    @IBAction func connexionAction(_ sender: Any) {
       
        facebookBtn.addTarget(self, action:#selector(BtnPressed(_:)), for: .touchDown);

        
        if (email.text == ""){
            email.errorMessage = "Champs obligatoire"
        }
        else {email.errorMessage = ""}
        //validate password
        
        if (password.text == ""){ password.errorMessage = "Champs obligatoire"
        }
        
        else {password.errorMessage = ""}
        
        
        WebServiceBP.sharedInstance().login(email.text!, password: password.text!) { (isTrue) in
            if isTrue{
                print("success login with mail")
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
                
                
                let vc5 = self.storyboard?.instantiateViewController(withIdentifier: "NotificationsViewController"
                    ) as! NotificationsViewController
                let controllers = [vc3, vc1, vc2, vc5, vc4]

                vc.viewControllers = controllers
                   vc.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
                self.navigationController?.pushViewController(vc, animated: true)
            //    self.navigationController?.present(vc, animated: true, completion: nil)
            }
            else {print("failure login with mail")
                
                
                
            }
        }
        
        
        
    }
    @IBAction func googleBtn(_ sender: Any) {
        /* WebServiceBP.sharedInstance().signInSocialMedia(email.text!, provider: "google", provider_id:) { (isTrue) in
            if isTrue{
                print("success login with mail")
            }
            else {print("failure login with mail")}
 
    }*/
        GIDSignIn.sharedInstance()?.signOut()
            GIDSignIn.sharedInstance().signIn()

    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error?) {
        print("User Logged In")
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
        
        
        let vc5 = self.storyboard?.instantiateViewController(withIdentifier: "NotificationsViewController"
            ) as! NotificationsViewController
        let controllers = [vc3, vc1, vc2, vc5, vc4]
        
        vc.viewControllers = controllers
        vc.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        self.navigationController?.pushViewController(vc, animated: true)
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
           let user_id = UserDefaults.standard.set(1, forKey: "user_id")
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            print("GOOGLE ", userId, idToken)
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
    
    @IBAction func facebookBtn(_ sender: Any) {
        
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile], viewController: nil) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success( _, _, _):
                print("Logged in!")
                
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
                
                let vc5 = self.storyboard?.instantiateViewController(withIdentifier: "NotificationsViewController"
                    ) as! NotificationsViewController
                let controllers = [vc3, vc1, vc2, vc5, vc4]
                vc.viewControllers = controllers
                vc.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
//self.dismiss(animated: true, completion: nil)
    }
   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    @IBAction func passwordForgotten(_ sender: Any) {
        
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "resendMailViewController"
                ) as! resendMailViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
 
