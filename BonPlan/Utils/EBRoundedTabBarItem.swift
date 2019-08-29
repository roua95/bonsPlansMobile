//
//  EBRoundedTabBarItem.swift
//  RoundedTabBarControllerExample
//
//  Created by Erid Bardhaj on 10/28/18.
//  Copyright © 2018 Erid Bardhaj. All rights reserved.
//

import UIKit

enum EBRoundedTabBarItem {
    case firstItem, secondItem, roundedItem, thirdItem, fourthItem
    
    var isRoundedItem: Bool {
        if case self = EBRoundedTabBarItem.roundedItem {
            return true
        }
        
        return false
    }
    /* var whichItem: String {
        if (case self = EBRoundedTabBarItem.firstItem)
        {return "Home"}
        
        if (case self = EBRoundedTabBarItem.firstItem)
        {return "Home"}
        if (case self = EBRoundedTabBarItem.firstItem)
        {return "Home"}
        if (case self = EBRoundedTabBarItem.firstItem)
        {return "Home"
    }
}*/
}
extension EBRoundedTabBarItem {
    
    var title: String {
        if isRoundedItem {
            return "Add Plan"
        }
        
        return "Custom"
    }
    
    var isEnabled: Bool {
        return !isRoundedItem
    }
    
    var tag: Int {
        switch self {
        case .firstItem:
            return 1
        case .secondItem:
            return 2
        case .roundedItem:
            return 3
        case .thirdItem:
            return 4
        case .fourthItem:
            return 5
        }
    }
    
    var image: UIImage? {
        if isRoundedItem {
            return UIImage(named: "cercleInsider")
        }
        
      //  return #imageLiteral(resourceName: "filled-circle.pdf")
        return nil
    }
    
    var tabBarItem: UITabBarItem {
        let tabItem = UITabBarItem(title: title, image: image, tag: tag)
        tabItem.isEnabled = isEnabled
        return tabItem
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .firstItem:
            return .cyan
        case .secondItem:
            return .green
        case .thirdItem:
            return .orange
        case .fourthItem:
            return .gray
        default:
            return .white
        }
    }
}

