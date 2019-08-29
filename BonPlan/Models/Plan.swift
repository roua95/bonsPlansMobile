//
//  Plan.swift
//  BonPlan
//
//  Created by DEVLOPER on 25/03/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import Foundation
import UIKit

class Plan {
    var title : String
    var image: URL
    var description: String
    var longitude:Double
    var lattitude:Double
    var id:Int
    var region:String
    var adress: String
    var user_id: Int
    var rate : Double
    
    init(image: URL, description: String,adress:String,user_id:Int,longitude: Double,lattitude:Double,region:String,id:Int,title:String,rate : Double) {
        self.image = image
        self.description = description
        self.id = id
        self.longitude = longitude
        self.lattitude = lattitude
        self.region = region
        self.adress = adress
        self.user_id = user_id
        self.title = title
        self.rate = rate
    }
}
