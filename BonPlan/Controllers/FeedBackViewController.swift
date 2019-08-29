//
//  FeedBackViewController.swift
//  BonPlan
//
//  Created by DEVLOPER on 05/04/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit

class FeedBackViewController: UIViewController {

    @IBOutlet weak var jadore: UIImageViewX!
    @IBOutlet weak var bien: UIImageViewX!
    
    @IBOutlet weak var envoyer: UIButtonX!
    
    @IBOutlet weak var jadoreCheckView: UIViewX!
    @IBOutlet weak var bienCheckView: UIViewX!
    @IBOutlet weak var bienCheck: UIImageViewX!
    @IBOutlet weak var neutreCheck: UIImageViewX!
    @IBOutlet weak var jadoreCheck: UIImageView!
    @IBOutlet weak var neutreCheckView: UIViewX!
    @IBOutlet weak var tristeCheck: UIImageViewX!
    @IBOutlet weak var tristeCheckView: UIViewX!
    @IBOutlet weak var bienView: UIViewX!
    @IBOutlet weak var triste: UIImageViewX!
    @IBOutlet weak var neutre: UIImageViewX!
    @IBOutlet weak var neutreView: UIViewX!
    @IBOutlet weak var tristeView: UIViewX!
    
    @IBOutlet weak var sentence2: UILabel!
    @IBOutlet weak var sentence1: UILabel!
    @IBOutlet weak var jadoreView: UIViewX!
    
    @IBOutlet weak var backBtn: UIButtonX!
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer, view :UIView){
        
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if (tappedImage == jadoreView && jadoreCheckView.isHidden == true ) {
            jadoreCheckView.isHidden = false
        }
        let state = view.isHidden
        if (state == true)
        { view.isHidden = false}
        else {view.isHidden = true }
    
    
    }
    
    @IBAction func backBtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PlusViewController") as! PlusViewController
        self.dismiss(animated: true, completion: nil)
        
        
    }
    func tap(gesture: UIGestureRecognizer,view : UIView) {
        
        let state = view.isHidden
        if (state == true)
        { view.isHidden = false}
        else {view.isHidden = true }
    }
    
    @objc func tapActionJadore(_ sender:UITapGestureRecognizer){
            jadoreCheckView.isHidden = false
            bienCheckView.isHidden = true
            neutreCheckView.isHidden = true
            tristeCheckView.isHidden = true
        
    }
    @objc func tapActionBien(_ sender:UITapGestureRecognizer){
            jadoreCheckView.isHidden = true
            bienCheckView.isHidden = false
            neutreCheckView.isHidden = true
            tristeCheckView.isHidden = true
        
    }
    @objc func tapActionNeutre(_ sender:UITapGestureRecognizer){
            jadoreCheckView.isHidden = true
            bienCheckView.isHidden = true
            neutreCheckView.isHidden = false
            tristeCheckView.isHidden = true
        
    }
    @objc func tapActiontriste(_ sender:UITapGestureRecognizer){
            jadoreCheckView.isHidden = true
            bienCheckView.isHidden = true
            neutreCheckView.isHidden = true
            tristeCheckView.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.jadoreCheckView.isHidden = true
        self.bienCheckView.isHidden = true
        self.tristeCheckView.isHidden = true
        self.neutreCheckView.isHidden = true
        weak var jadoreView: UIViewX!

        
        let gesturejadoreView = UITapGestureRecognizer(target: self, action:  #selector (self.tapActionJadore (_:)))
        let gesturebienView = UITapGestureRecognizer(target: self, action:  #selector (self.tapActionBien(_:)))
        let gestureneutreView = UITapGestureRecognizer(target: self, action:  #selector (self.tapActionNeutre(_:)))
        let gesturetristeView = UITapGestureRecognizer(target: self, action:  #selector (self.tapActiontriste(_:)))
        
        self.jadoreView.addGestureRecognizer(gesturejadoreView)
            self.bienView.addGestureRecognizer(gesturebienView)
        self.neutreView.addGestureRecognizer(gestureneutreView)
        self.tristeView.addGestureRecognizer(gesturetristeView)
      
    
    func envoyerAction(_ sender: UIButton) {
        
    }
        let label1 = NSLocalizedString("Comment vous sentez-vous", comment: "")
        
        let label2 = NSLocalizedString("à propos de Planify", comment: "")
        let btn = NSLocalizedString("envoyer", comment: "")
        
        sentence1.text = label1
        sentence2.text = label2
        envoyer.setTitle(btn, for: .normal)

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
/*drafts
 for example jadore view
if jadore clicked ===> check state ===> if checked uncheck
else check
if jadore clicked and another view checked ===> uncheck view and check jadore
*/
