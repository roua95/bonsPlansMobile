//
//  initialViewController.swift
//  bon_plan
//
//  Created by DEVLOPER on 15/02/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//
import UIKit

class initialViewController: UIViewController {

    @IBOutlet weak var signin: UIButton!
    
    
    @IBOutlet weak var sign_up: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func signin(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "sign-inViewController"
            ) as! sign_inViewController
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    
    
    @IBAction func signup(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "sign_upViewController"
            ) as! sign_upViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    }
    

