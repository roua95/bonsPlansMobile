//
//  CategoriesCollectionViewCell.swift
//  BonPlan
//
//  Created by DEVLOPER on 27/03/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categorieLabel: UILabelX!
    @IBOutlet weak var categorieImage: UIImageViewX!
    func displayContent(image: UIImage, title: String) {
        categorieImage.image = image
        categorieLabel.text = title
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
