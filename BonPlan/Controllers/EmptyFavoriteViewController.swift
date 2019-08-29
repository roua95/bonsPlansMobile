//
//  EmptyFavoriteViewController.swift
//  BonPlan
//
//  Created by DEVLOPER on 08/04/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit

class EmptyFavoriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationsViewController"
            ) as! NotificationsViewController
        self.present(vc, animated: true, completion: nil)

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
