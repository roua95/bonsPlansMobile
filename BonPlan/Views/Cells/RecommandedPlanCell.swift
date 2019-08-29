//
//  RecommandedPlanCell.swift
//  BonPlan
//
//  Created by DEVLOPER on 01/04/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit

class RecommandedPlanCell: UICollectionViewCell {

    @IBOutlet weak var imagePlan: UIImageView!
    @IBOutlet weak var planTitle: UILabel!
    
    @IBOutlet weak var likesNbr: UILabel!
    @IBOutlet weak var categoryImage: UIImageViewX!
    
    @IBAction func likeAction(_ sender: Any) {
        WebServiceBP.init().likePlan(plan_id: 13, user_id: 1) { (isTrue) in
            
           /* self.jaimebtn.setImage(UIImage(named: "jaime"), for: .normal)
            self.jaimebtn.setImage(UIImage(named: "like"), for: .selected)
            */
            WebServiceBP.init().getPlanLikes(plan_id: 13) { (response, isTrue) in
                if isTrue{
                    // self.plans.removeAll()
                    self.likesNbr.text = response
                    
                }}
        }
    }
    @IBOutlet weak var likeBtn: UIButtonX!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var categoryLabel: UILabel!
    
    public func configure(with model: Plan) {
       // imagePlan.image = model.image
        planTitle.text = model.title
        imagePlan.kf.setImage(with: model.image)
       categoryImage.image = UIImage(named: "resto")
        
    }
}
