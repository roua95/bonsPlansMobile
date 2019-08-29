//
//  resendMailViewController.swift
//  BonPlan
//
//  Created by DEVLOPER on 04/03/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit

class resendMailViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var mail: SkyFloatingLabelTextFieldWithIcon!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var envoyer: UIButtonX!
    

    @IBAction func mail(_ sender: Any) {
    }
    
     @IBAction func envoyer(_ sender: Any) {
     }
    
    @IBAction func backBtn(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)

    }
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
