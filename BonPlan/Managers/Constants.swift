//
//  Constants.swift
//  Pasha
//
//  Created by DEVLOPER on 05/08/2018.
//  Copyright © 2018 DEVLOPER. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    // Webservices

    static let baseURL = "http://127.0.0.1:8000/"
    static let apiURL = baseURL + "api/"
    static let apiAuthURL = apiURL + "login"
    static let expertise = "expertise"
    static let register = "auth/register"
    static let registerfacebook = "auth/registerfacebook"
    static let registergoogle = "auth/registergoogle"
    static let country = "country"
    static let loginfacebook = "auth/loginfacebook"
    static let logingoogle = "auth/logingoogle"
    static let login = "login"
    static let inspirations = "inspirations"
    

    // Status codes
    static let success = "Success"
    static let codesuccess = "200"
    static let codefailure = "404"
    static let notAvailable = "02"
    static let overlap = "01"
    static let timesame = "03"
    static let nogarage = "04"
    static let failure = "failed"
    static let invalidlogin = "405"
    static let emailnotconfirmed = "401"
    static let accountlocked = "403"
    static let tokenError = 12
    static let notfound = "404"
    static let notfoundgarage = "406"
    static let invaliduser = "422"
    static let emailExists = 14
    static let permissionDenied = 20
    static let accountNotConfirmed = 21
    static let accountBanned = 22
    static let serverError = 500
    
    // Custom Colors
    static let customRed = UIColor(red: 196/255, green: 52/255, blue: 86/255, alpha: 1.0)
    static let customGrey = UIColor(red: 149/255, green: 149/255, blue: 163/255, alpha: 1.0)
    static let customPurple = UIColor(red: 105/255, green: 79/255, blue: 167/255, alpha: 1.0)
    static let customDarkBlue = UIColor(red: 47/255, green: 84/255, blue: 133/255, alpha: 1.0)
    static let anotherBlue = UIColor(red: 89/255, green: 122/255, blue: 239/255, alpha: 1.0)
    static let anotherBlueWithAlpha = UIColor(red: 89/255, green: 122/255, blue: 239/255, alpha: 0.5)
    static let customBlack = UIColor(red: 36/255, green: 36/255, blue: 36/255, alpha: 1.0)
    static let themeColor = UIColor(red: 0/255, green: 96/255, blue: 114/255, alpha: 1.0)
}
