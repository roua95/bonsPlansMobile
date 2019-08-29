//
//  CategoriesCollectionViewCell.swift
//  BonPlan
//
//  Created by DEVLOPER on 27/03/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit

protocol categorySelectedDelegate {
    func valueLable(update : String)
}
class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categorieLabel: UILabelX!
   
    var delegate : categorySelectedDelegate?

    func displayContent(image: UIImage, title: String) {
        categorieImage.image = image
        categorieLabel.text = title
    }
    
    
    @IBOutlet weak var categorieImage: UIImageViewX!
    func categoryLabelAction(label: UILabelX,image:UIImageView, alpha: CGFloat) -> Void {
        label.alpha = alpha
        image.alpha = alpha
        WebServiceBP.init().getPlansFromCategory(categorie: (categorieLabel.text!)) { (response,isTrue) in
            if isTrue{
                print ("this is category clicked",self.categorieLabel.text)
                for rep in response{
                    let id = (rep as AnyObject).object(forKey: "id") as! Int
                    let title = (rep as AnyObject).object(forKey: "title") as! String
                    let longitude = ((rep as AnyObject).object(forKey: "longitude") as!NSString).doubleValue
                    let latitude = ((rep as AnyObject).object(forKey: "lattitude") as!NSString).doubleValue
                    
                    let region = (rep as AnyObject).object(forKey: "region") as! String
                    let description = (rep as AnyObject).object(forKey: "description") as! String
                    let adresse = (rep as AnyObject).object(forKey: "adresse") as! String
                    let rate = (rep as AnyObject).object(forKey: "rate") as! Double
                    let user_id = (rep as AnyObject).object(forKey: "user_id") as! Int
                    WebServiceBP.init().getImageForPlan(plan_id: id) { (response, isTrue) in
                        if isTrue{
                            for rep in response{
                                let imageURL = rep.object(forKey: "url") as! String
                                let URL_IMAGE = URL(string:imageURL )
                                let plan = Plan(image: URL_IMAGE!, description: description,adress:adresse, user_id: user_id, longitude: longitude, lattitude: latitude, region: region, id: id, title: title, rate: rate)
                                //call view controller from storyboard and instantiate vc or use dlegates
                               // plans.append(plan)
                               //  print("helloooo",plans.count)
                             //   bestVotedTableView.reloadData()
 
                               
                            }
                        }
                        
                    }
                }
            }}
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
