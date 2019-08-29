//
//  NotificationsViewController.swift
//  BonPlan
//
//  Created by DEVLOPER on 05/04/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {
    var favorited: [Plan] = []
    var plan :Plan = Plan(image:URL(string: "https://assets3.thrillist.com/v1/image/2797371/size/tmg-article_default_mobile.jpg")!,description: "café Resto",adress:"sousse", user_id: 2, longitude: 35, lattitude: 28, region: "sousse", id: 1, title: "toscana", rate: 4)

    @IBOutlet weak var tableviewNotif: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableviewNotif.delegate = self
        tableviewNotif.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        WebServiceBP.init().getFavoritedPlans(user_id:0  //UserDefaults.standard.integer(forKey: "user_id")
        ){ (response, isTrue) in
            if isTrue{
                self.favorited.removeAll()
                for rep in response{
                    let id = rep.object(forKey: "id") as! Int
                    let title = rep.object(forKey: "title") as! String
                    let longitude = (rep.object(forKey: "longitude") as!NSString).doubleValue
                    let latitude = (rep.object(forKey: "lattitude") as!NSString).doubleValue
                    
                    let region = rep.object(forKey: "region") as! String
                    let description = rep.object(forKey: "description") as! String
                    let adresse = rep.object(forKey: "adresse") as! String
                    let rate = rep.object(forKey: "rate") as! Double
                    let user_id = rep.object(forKey: "user_id") as! Int
                    
                    
                    WebServiceBP.init().getImageForPlan(plan_id: id) { (response2, isTrue) in
                        if isTrue{
                            var imageURL = ""
                            var URL_IMAGE = URL(string:imageURL)
                            for rep2 in response2{
                                imageURL = rep2.object(forKey: "url") as! String
                                URL_IMAGE = URL(string:imageURL)
                                print(self.favorited.count)
                                print("helloooo from favorited")
                                self.plan = Plan(image: URL(string:imageURL)!, description: description,adress:adresse, user_id: user_id, longitude: longitude, lattitude: latitude, region: region, id: id, title: title,rate: rate)
                                
                                self.favorited.append(self.plan)
                            }
                            self.tableviewNotif.reloadData()
                        }
                    }
                    
                }
                
            }
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PlusViewController") as! PlusViewController
        self.dismiss(animated: true, completion: nil)
        self.present(nextViewController, animated:true, completion:nil)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NotificationsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorited.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            ///ta7wil wejha :p notif hiya bidha favorite
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotifTableViewCell") as! NotifTableViewCell

             cell.nomUser.kf.setImage(with: self.favorited[indexPath.row].image)
            cell.notifDescription.text = favorited[indexPath.row].title
            cell.notifDate.text = favorited[indexPath.row].adress
            return cell
        
    }
}
