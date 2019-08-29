//
//  GoogleMapTableViewCell.swift
//  BonPlan
//
//  Created by DEVLOPER on 11/04/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit
import GoogleMaps
class GoogleMapTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var mapView: GMSMapView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
