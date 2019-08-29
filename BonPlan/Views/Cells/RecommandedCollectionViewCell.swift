//
//  RecommandedCollectionViewCell.swift
//  BonPlan
//
//  Created by DEVLOPER on 29/03/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit

class RecommandedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var planTitle: UILabel!
    
    func displayContent(image: UIImage, title: String) {
        recommandedPlanImage.image = image
        planTitle.text = title
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
//planTitle  recommandedPlanImage
