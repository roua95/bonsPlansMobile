//
//  BestVotedViewCellTableViewCell.swift
//  BonPlan
//
//  Created by DEVLOPER on 28/03/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit

class BestVotedViewCellTableViewCell: UITableViewCell {

    @IBOutlet weak var categorie: UIImageViewX!
    
    @IBOutlet weak var likesNumber: UITextFieldX!
    @IBOutlet weak var like: UIImageViewX!
    @IBOutlet weak var categorieText: UITextField!
    @IBOutlet weak var planTitle: UITextFieldX!
    
    @IBOutlet weak var bonPlanViewImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
