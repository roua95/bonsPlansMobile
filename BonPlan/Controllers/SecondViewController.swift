//
//  SecondViewController.swift
//  bon_plan
//
//  Created by DEVLOPER on 13/02/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class SecondViewController: UIViewController{
    
    @IBOutlet weak var firstNamelabel: UILabel!
    
    @IBOutlet weak var lastNamelabel: UILabel!
    
    
    @IBOutlet weak var emaillabel: UILabel!
    
    var firstNamelabelText = ""
    var lastNamelabelText: String?
    var emaillabelText: String?
    var test: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*WebServiceManager.sharedInstance().getCountries {(response, isTrue) in
         if isTrue{
         print(response)
         for country in response{
         let id = country.object(forKey: "id") as! Int
         self.test.append(id)
         }
         
         }*/
        
        firstNamelabel.text = firstNamelabelText
        lastNamelabel.text = lastNamelabelText
        emaillabel.text = emaillabelText
        
        WebServiceManager.sharedInstance().login("rou@gmail.com", password: "roua") { (isTrue) in
            if isTrue{
                print("success")
            }
        }
      
        /*Alamofire.request("http://api.androidhive.info/contacts/").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                print(swiftyJsonVar)
            }
        }*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    @IBAction func btnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "sign_upViewController"
            ) as! sign_upViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
