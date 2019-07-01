//
//  sign-inViewController.swift
//  bon_plan
//
//  Created by DEVLOPER on 15/02/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit

class sign_inViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print ("hello")
    }
    @IBAction func email(_ sender: Any) {
    }
    
    @IBAction func password(_ sender: Any) {
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
