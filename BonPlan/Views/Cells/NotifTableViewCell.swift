//
//  NotifTableViewCell.swift
//  BonPlan
//
//  Created by DEVLOPER on 08/04/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit

class NotifTableViewCell: UITableViewCell {

    @IBOutlet weak var notifDescription: UILabel!
    @IBOutlet weak var notifDate: UILabel!
    @IBOutlet weak var nomUser: UIImageViewX!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
