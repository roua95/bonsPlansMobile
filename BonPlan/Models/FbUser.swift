//
//  FbUser.swift
//  BonPlan
//
//  Created by DEVLOPER on 12/03/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import Foundation

class FbUser{
    
    
    let userId: Int
    let userFirstName: String
    let userLastName: String
    let userEmail: String
    
    init(userId:Int,userFirstName:String,userLastName:String,userEmail:String) {
        self.userId = userId
        self.userFirstName = userFirstName
        self.userLastName = userLastName
        self.userEmail = userEmail
    }
    func set(_ value: Any?,
             forKey defaultName: String){
        let defaultName = value
    }
    }


