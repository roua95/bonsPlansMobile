//
//  BestVotedViewCellTableViewCell.swift
//  BonPlan
//
//  Created by DEVLOPER on 28/03/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit
import Cosmos
import TinyConstraints

class BestVotedViewCellTableViewCell: UITableViewCell {

    @IBOutlet weak var categorie: UIImageViewX!
    
    @IBOutlet weak var bonPlanViewImage: UIImageViewX!
    @IBOutlet weak var likesNumber: UILabel!
    @IBOutlet weak var jaime: UIButton!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var categorieText: UITextField!
    @IBOutlet weak var planTitle: UITextFieldX!
    @IBAction func likeAction(_ sender: Any) {
        jaime.setTitle("j'aime", for : UIControl.State.normal)
        jaime.setImage(UIImage(named : "jaime"), for: UIControl.State.normal)
        ////find an image "jaimeplus"        jaime.setImage(UIImage(named : "jaimeplus"), for: UIControl.State.selected)
    //    jaime.addTarget(self, action: #selector(myButtonTapped), for: UIControl.Event.touchUpInside)
    }
    @objc func myButtonTapped(){
        if jaime.isSelected == true {
            jaime.isSelected = false
            
            
        }else {
            jaime.isSelected = true
            
        }
        //call like web service && likenumber update
       /*
        WebServiceBP.init().likePlan(plan_id: 1, user_id: 1){(isTrue) in
            
            
            WebServiceBP.init().likesNumber(plan_id: 1) { (response) in
                self.likesNumber.text = response
 
            }
 */
        
    
    }
    
    lazy var cosmosView: CosmosView = {
        var view = CosmosView()
        return view
    }()
    
    func createCosmosView(view: UIView) {
        let cosmosView = CosmosView()
        view.addSubview(cosmosView)
        cosmosView.rightToSuperview()
        

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}

