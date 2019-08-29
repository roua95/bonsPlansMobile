//
//  CommentTableViewCell.swift
//  BonPlan
//
//  Created by DEVLOPER on 16/05/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var userName: UILabelX!
    @IBOutlet weak var commentText: UILabel!
    
    @IBOutlet weak var userPhoto: UIImageViewX!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        self.userName.text = "Moi"
        self.commentText.text = "great"
        
        
    }
    
}
