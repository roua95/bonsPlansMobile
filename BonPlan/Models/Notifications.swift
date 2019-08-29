//
//  Notifications.swift
//  BonPlan
//
//  Created by DEVLOPER on 10/04/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import Foundation
import UIKit
class Notifications{
    
    var id:Int
    var nomUser:String
    var date:String
    var description:String

    init(id:Int,nomUser:String,date:String,description:String) {
        self.id = id
        self.nomUser = nomUser
        self.date = date
        self.description = description
}
}
