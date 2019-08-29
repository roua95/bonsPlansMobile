//
//  UITabBarViewController.swift
//  BonPlan
//
//  Created by DEVLOPER on 03/05/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit

class UITabBarViewController: UITabBarController,UITabBarControllerDelegate {

    
    @IBOutlet weak var TabBar: UITabBar!
    var home = UIImage(named: "home")
    var profile = UIImage(named: "profile")
    var favoris = UIImage(named: "favoris")
    var more = UIImage(named: "more")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*
        let controller1 = FiltersViewController()
        controller1.tabBarItem = UITabBarItem(title: "Home", image: home, selectedImage: home)
        let nav1 = UINavigationController(rootViewController: controller1)
        
        let controller2 = ProfileViewController()
       // controller2.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        controller2.tabBarItem = UITabBarItem(title: "Profile", image: profile, selectedImage: profile)
        
        let nav2 = UINavigationController(rootViewController: controller2)
        
        let controller3 = EmptyFavoriteViewController()
        controller3.tabBarItem = UITabBarItem(title: "Favoris", image: favoris, selectedImage: favoris)
        
        let nav3 = UINavigationController(rootViewController: controller3)
        nav3.title = ""
        
        let controller4 = PlusViewController()
       // controller4.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 4)
        controller4.tabBarItem = UITabBarItem(title: "Plus", image: more, selectedImage: more)
        
        let nav4 = UINavigationController(rootViewController: controller4)
        
        
        viewControllers = [nav1, nav2, nav3, nav4]
        setupMiddleButton()
    }
    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 52, height: 52))
        
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        
        menuButton.backgroundColor = UIColor.white
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        view.addSubview(menuButton)
        
        menuButton.setImage(UIImage(named: "cercleInsider"), for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        
        view.layoutIfNeeded()
    }
    
    
    // MARK: - Actions
    
    @objc private func menuButtonAction(sender: UIButton) {
        let nextViewController = storyboard?.instantiateViewController(withIdentifier: "AjoutPlanViewController") as! AjoutPlanViewController
        self.present(nextViewController, animated:true, completion:nil)
        
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


*/
}
}
