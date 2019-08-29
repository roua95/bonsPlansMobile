//
//  Commentaire.swift
//  BonPlan
//
//  Created by DEVLOPER on 25/03/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import Foundation
import UIKit

class Commentaire {
    
    var user_id: Int
    var plan_id: Int
    var text: String
    init(user_id:Int,plan_id:Int,text:String){
        self.user_id = user_id
        self.plan_id = plan_id
        self.text = text
    }
    
}
