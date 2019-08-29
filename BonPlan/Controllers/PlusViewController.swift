//
//  PlusViewController.swift
//  BonPlan
//
//  Created by DEVLOPER on 04/04/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit

class PlusViewController: UIViewController {

    @IBOutlet weak var backbtn: UIButtonX!
    @IBOutlet weak var notifications: UIButton!
    
    @IBOutlet weak var switchBTN: UISwitch!
    @IBOutlet weak var languages: UIButton!
    @IBOutlet weak var feedback: UIButton!
    @IBOutlet weak var aPropos: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FeedBackViewController") as! FeedBackViewController
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    @IBAction func feedback(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FeedBackViewController") as! FeedBackViewController
        self.present(nextViewController, animated:true, completion:nil)
        
        
    }
    @IBAction func languages(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LanguagesViewController") as! LanguagesViewController
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    @IBAction func notifications(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationsViewController") as! NotificationsViewController
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    @IBAction func switchBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "sign_upViewController"
            ) as! sign_upViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func aPropos(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "sign_upViewController"
            ) as! sign_upViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    /*
     @IBAction func `switch`(_ sender: Any) {
     }
     @IBOutlet weak var backbtn: UIImageViewX!
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
