//
//  GoogleMapsLocalisationTableViewCell.swift
//  BonPlan
//
//  Created by DEVLOPER on 25/03/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleMapsLocalisationTableViewCell: UITableViewCell {

    @IBOutlet weak var mapView: GMSMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
