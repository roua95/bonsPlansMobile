//
//  LanguagesViewController.swift
//  BonPlan
//
//  Created by DEVLOPER on 05/04/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit

class LanguagesViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButtonX!
    @IBOutlet weak var anglaisView: UIViewX!
    @IBOutlet weak var françaisView: UIViewX!
    @IBOutlet weak var arabeView: UIViewX!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backBtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PlusViewController") as! PlusViewController
        self.dismiss(animated: true, completion: nil)
        self.present(nextViewController, animated:true, completion:nil)

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
