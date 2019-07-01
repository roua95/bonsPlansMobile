//
//  CommentsCell.swift
//  BonPlan
//
//  Created by DEVLOPER on 26/03/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit

class CommentsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var avis: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
