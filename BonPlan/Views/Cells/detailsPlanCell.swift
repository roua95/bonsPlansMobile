//
//  detailsPlanCell.swift
//  BonPlan
//
//  Created by DEVLOPER on 25/03/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//
import Cosmos
import UIKit
class detailsPlanCell: UITableViewCell {

    @IBOutlet weak var planImage: UIImageView!
    weak var viewController: ImageListScreen?
    @IBOutlet weak var comment_text: UITextView!
    
    
    @IBOutlet weak var addFav: UIButtonX!
    func getPlanImage() -> UIImageView{
        return self.planImage
    }
    @IBOutlet weak var commenter: UILabel!
    
    @IBOutlet weak var partager: UILabel!
    
    
    @IBOutlet weak var rate: CosmosView!
    
    @IBOutlet weak var jaime: UILabelX!
    @IBOutlet weak var jaimebtn: UIButtonX!
    
    @IBOutlet weak var commenter_btn: UIButtonX!
    
    
    @IBOutlet weak var cosmosView: UIView!
    @IBOutlet weak var partager_btn: UIButton!
    
    @IBAction func jaimeAction(_ sender: UIButtonX) {
     
        WebServiceBP.init().likePlan(plan_id: 13, user_id: 1) { (isTrue) in
            
            self.jaimebtn.setImage(UIImage(named: "jaime"), for: .normal)
            self.jaimebtn.setImage(UIImage(named: "like"), for: .selected)
            
            WebServiceBP.init().getPlanLikes(plan_id: 13) { (response, isTrue) in
                if isTrue{
                    // self.plans.removeAll()
                    self.jaime.text = response
                    
                }}
            }
        }
      
    
    @IBAction func commenterAction(_ sender: UIButtonX) {
    }
    
    @IBAction func partagerAction(_ sender: UIButtonX) {

       // if let image = planImage.image {
         if let image = UIImage(named: "like") {

            let vc = UIActivityViewController(activityItems: [comment_text.text, image], applicationActivities: [])
            viewController?.present(vc, animated: true)
    }
}
    
}

