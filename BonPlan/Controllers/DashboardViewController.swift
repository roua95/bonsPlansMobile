//
//  DashboardViewController.swift
//  BonPlan
//
//  Created by DEVLOPER on 27/03/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

/*https://github.com/yayitserica/Collection-View-Data-Source-Blog/blob/master/CollectionViewBlog/APIClient.swift */
import UIKit
import Cosmos
import TinyConstraints
import Kingfisher
import UserNotifications

class DashboardViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, categoryDelegate,UITextFieldDelegate{
    func planSelected(plan: Plan) {
        print("this is plan delegate")
    }
    
    var selectedCategory:String = ""
    
    var user_id = UserDefaults.standard.integer(forKey: "user_id")
    var plan_id:Int = 1
    var plan :Plan = Plan(image:URL(string: "https://assets3.thrillist.com/v1/image/2797371/size/tmg-article_default_mobile.jpg")!,description: "café Resto",adress:"sousse", user_id: 2, longitude: 35, lattitude: 28, region: "sousse", id: 1, title: "toscana", rate: 4)
    
    
    @IBOutlet weak var RecommandedPlanCollectionView: UICollectionView!
    @IBOutlet weak var bestVotedTableView: UITableView!
    @IBOutlet weak var collectionViewCategories: UICollectionView!
    @IBOutlet weak var rechercher: UITextFieldX!
    
    @IBAction func regionTapped(_ sender: UITextFieldX) {
        self.plans.removeAll()
        WebServiceBP.init().researchPlanByRegion(region: (region.text ?? "sousse")) { (response,isTrue) in
            if isTrue{
                for rep in response{
                    let id = (rep as AnyObject).object(forKey: "id") as! Int
                    let title = (rep as AnyObject).object(forKey: "title") as! String
                    let longitude = ((rep as AnyObject).object(forKey: "longitude") as!NSString).doubleValue
                    let latitude = ((rep as AnyObject).object(forKey: "lattitude") as!NSString).doubleValue
                    
                    let region = (rep as AnyObject).object(forKey: "region") as! String
                    let description = (rep as AnyObject).object(forKey: "description") as! String
                    let adresse = (rep as AnyObject).object(forKey: "adresse") as! String
                    let rate = (rep as AnyObject).object(forKey: "rate") as! Double
                    let user_id = (rep as AnyObject).object(forKey: "user_id") as! Int
                    WebServiceBP.init().getImageForPlan(plan_id: id) { (response, isTrue) in
                        if isTrue{
                            for rep in response{
                                let imageURL = rep.object(forKey: "url") as! String
                                let URL_IMAGE = URL(string:imageURL )
                                 self.plan = Plan(image: URL_IMAGE!, description: description,adress:adresse, user_id: user_id, longitude: longitude, lattitude: latitude, region: region, id: id, title: title, rate: rate)
                                self.plans.append(self.plan)
                                self.bestVotedTableView.reloadData()
                            }
                        }
                        
                    }
                }
            }}
    }
    @IBOutlet weak var notif: UIButtonX!
    @IBOutlet weak var region: UITextFieldX!
    @IBOutlet weak var filterBtn: UIButtonX!
    var category :String = ""
    @IBAction func notifAction(_ sender: Any) {
        //// if no notifications found
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationsViewController"
            ) as! NotificationsViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        ////else
        let notification = UILocalNotification()
        notification.alertBody = "Welcome to the app!" // text that will be displayed in the notification
        
        notification.fireDate = NSDate(timeIntervalSinceNow: 2) as Date
        notification.soundName = UILocalNotificationDefaultSoundName
        
        notification.userInfo = ["title": "Title", "UUID": "12345"]
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
    @IBAction func filterButtonAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FiltersViewController"
            ) as! FiltersViewController
        
        vc.delegate = self
        //self.navigationController?.pushViewController(vc, animated: true)
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(vc, animated: false, completion: nil)
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    var categories: [Categorie] = []
    
    var images: [UIImage] = []
    
    var plans: [Plan] = []
    var RecommandedPlans: [Plan] = []
    
    var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    override func viewWillAppear(_ animated: Bool) {
        //  recommandedRelated()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rechercher.resignFirstResponder()
        self.region.resignFirstResponder()
        self.region.delegate = self
        self.rechercher.delegate = self
        
        ////here recommanded plans filled
        
        WebServiceBP.init().getRecommandedPlans(min:3){ (response, isTrue) in
            if isTrue{
                for rep in response{
                    let id = (rep as AnyObject).object(forKey: "id") as! Int
                    let title = (rep as AnyObject).object(forKey: "title") as! String
                    let longitude = ((rep as AnyObject).object(forKey: "longitude") as!NSString).doubleValue
                    let latitude = ((rep as AnyObject).object(forKey: "lattitude") as!NSString).doubleValue
                    
                    let region = (rep as AnyObject).object(forKey: "region") as! String
                    let description = (rep as AnyObject).object(forKey: "description") as! String
                    let adresse = (rep as AnyObject).object(forKey: "adresse") as! String
                    let rate = (rep as AnyObject).object(forKey: "rate") as! Double
                    let user_id = (rep as AnyObject).object(forKey: "user_id") as! Int
                    WebServiceBP.init().getImageForPlan(plan_id: id) { (response, isTrue) in
                        if isTrue{
                            for rep in response{
                                let imageURL = rep.object(forKey: "url") as! String
                                let URL_IMAGE = URL(string:imageURL )
                                self.plan = Plan(image: URL_IMAGE!, description: description,adress:adresse, user_id: user_id, longitude: longitude, lattitude: latitude, region: region, id: id, title: title,rate: rate)
                                self.RecommandedPlans.append(self.plan)
                                print("helloooo from recommanded",self.RecommandedPlans.count)
                                self.RecommandedPlanCollectionView.reloadData()
                            }
                        }
                        
                    }
                }
            }
        }
        
        
        
        self.categories.append(Categorie(id: 1, nom: "Sport"))
        self.categories.append(Categorie(id: 2, nom: "cafe"))
        self.categories.append(Categorie(id: 3, nom: "resto"))
        self.categories.append(Categorie(id: 4, nom: "sante"))
        self.categories.append(Categorie(id: 5, nom: "boire"))
        let URL_IMAGE = URL(string: "http://www.simplifiedtechy.net/wp-content/uploads/2017/07/simplified-techy-default.png")
        let session = URLSession(configuration: .default)
        //creating a dataTask
        let getImageFromUrl = session.dataTask(with: URL_IMAGE!) { (data, response, error) in
            
            //if there is any error
            if let e = error {
                //displaying the message
                print("Error Occurred: \(e)")
                
            } else {
                //in case of now error, checking wheather the response is nil or not
                if (response as? HTTPURLResponse) != nil {
                    
                    //checking if the response contains an image
                    if let imageData = data {
                        
                        //getting the image
                        let image = UIImage(data: imageData)
                        
                        //displaying the image
                        
                    } else {
                        print("Image file is currupted")
                    }
                } else {
                    print("No response from server")
                }
            }
        }
        
        //starting the download task
        getImageFromUrl.resume()
        
        collectionViewCategories.delegate = self
        collectionViewCategories.dataSource = self
        
        bestVotedTableView.delegate = self
        bestVotedTableView.dataSource = self
        
        
        RecommandedPlanCollectionView.delegate = self
        RecommandedPlanCollectionView.dataSource = self
        
        collectionViewCategories.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        /* RecommandedPlanCollectionView.register(recommendedPlansCollectionViewCell.self, forCellWithReuseIdentifier: "recommendedPlansCollectionViewCell")
         */
        
        
        RecommandedPlanCollectionView.register(UINib.init(nibName: "RecommandedPlanCell", bundle: nil), forCellWithReuseIdentifier: "RecommandedPlanCell")
        
    }
    
    @IBAction func searchByName(_ sender: Any) {
        self.plans.removeAll()
        print(rechercher.text)
        
        WebServiceBP.init().researchPlanByName(title: rechercher.text ?? "Miami"){ (response,isTrue) in
            if isTrue{
                for rep in response{
                    let id = (rep as AnyObject).object(forKey: "id") as! Int
                    let title = (rep as AnyObject).object(forKey: "title") as! String
                    let longitude = ((rep as AnyObject).object(forKey: "longitude") as!NSString).doubleValue
                    let latitude = ((rep as AnyObject).object(forKey: "lattitude") as!NSString).doubleValue
                    
                    let region = (rep as AnyObject).object(forKey: "region") as! String
                    let description = (rep as AnyObject).object(forKey: "description") as! String
                    let adresse = (rep as AnyObject).object(forKey: "adresse") as! String
                    let rate = (rep as AnyObject).object(forKey: "rate") as! Double
                    let user_id = (rep as AnyObject).object(forKey: "user_id") as! Int
                    WebServiceBP.init().getImageForPlan(plan_id: id) { (response, isTrue) in
                        if isTrue{
                            for rep in response{
                                let imageURL = rep.object(forKey: "url") as! String
                                let URL_IMAGE = URL(string:imageURL )
                                self.plan = Plan(image: URL_IMAGE!, description: description,adress:adresse, user_id: user_id, longitude: longitude, lattitude: latitude, region: region, id: id, title: title, rate: rate)
                                self.plans.append(self.plan)
                                self.bestVotedTableView.reloadData()
                            }
                        }
                        
                    }
                }
            }}
    }
   
    @objc func relatedToLike(){
        WebServiceBP.init().likePlan(plan_id: self.plan_id, user_id: self.user_id){(isTrue) in
            
            
            // WebServiceBP.init().likesNumber(plan_id: plan_id) { (response) in
            // plan.likesNumber.text = response
            
        }}
        
        func valueLable(update : String){
            selectedCategory = update
            print( selectedCategory)
            WebServiceBP.init().getPlansFromCategory(categorie: (selectedCategory)) { (response,isTrue) in
                if isTrue{
                    for rep in response{
                        let id = (rep as AnyObject).object(forKey: "id") as! Int
                        let title = (rep as AnyObject).object(forKey: "title") as! String
                        let longitude = ((rep as AnyObject).object(forKey: "longitude") as!NSString).doubleValue
                        let latitude = ((rep as AnyObject).object(forKey: "lattitude") as!NSString).doubleValue
                        
                        let region = (rep as AnyObject).object(forKey: "region") as! String
                        let description = (rep as AnyObject).object(forKey: "description") as! String
                        let adresse = (rep as AnyObject).object(forKey: "adresse") as! String
                        let rate = (rep as AnyObject).object(forKey: "rate") as! Double
                        let user_id = (rep as AnyObject).object(forKey: "user_id") as! Int
                        WebServiceBP.init().getImageForPlan(plan_id: id) { (response, isTrue) in
                            if isTrue{
                                for rep in response{
                                    let imageURL = rep.object(forKey: "url") as! String
                                    let URL_IMAGE = URL(string:imageURL )
                                    self.plan = Plan(image: URL_IMAGE!, description: description,adress:adresse, user_id: user_id, longitude: longitude, lattitude: latitude, region: region, id: id, title: title,rate :rate)
                                    self.plans.append(self.plan)
                                    print("helloooo",self.plans.count)
                                    self.bestVotedTableView.reloadData()
                                }
                            }
                            
                        }
                    }
                }
                
            }
            
            
            
            
            func recommandedRelated(){
                WebServiceBP.init().getRecommandedPlans(min:3){ (response, isTrue) in
                    self.RecommandedPlans.removeAll()
                    if isTrue{
                        for rep in response{
                            let id = (rep as AnyObject).object(forKey: "id") as! Int
                            let title = (rep as AnyObject).object(forKey: "title") as! String
                            let longitude = ((rep as AnyObject).object(forKey: "longitude") as!NSString).doubleValue
                            let latitude = ((rep as AnyObject).object(forKey: "lattitude") as!NSString).doubleValue
                            
                            let region = (rep as AnyObject).object(forKey: "region") as! String
                            let description = (rep as AnyObject).object(forKey: "description") as! String
                            let adresse = (rep as AnyObject).object(forKey: "adresse") as! String
                            let rate = (rep as AnyObject).object(forKey: "rate") as! Double
                            let user_id = (rep as AnyObject).object(forKey: "user_id") as! Int
                            WebServiceBP.init().getImageForPlan(plan_id: id) { (response, isTrue) in
                                if isTrue{
                                    for rep in response{
                                        let imageURL = rep.object(forKey: "url") as! String
                                        let URL_IMAGE = URL(string:imageURL )
                                        self.plan = Plan(image: URL_IMAGE!, description: description,adress:adresse, user_id: user_id, longitude: longitude, lattitude: latitude, region: region, id: id, title: title, rate: rate)
                                        self.RecommandedPlans.append(self.plan)
                                        print("helloooo from recommanded",self.RecommandedPlans.count)
                                        //self.RecommandedPlanCollectionView.reloadData()
                                        // cell.configure(with: plan)
                                        
                                        
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
        }
    
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plans.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageListScreen"
            ) as! ImageListScreen
        print("selected ")
        vc.plan = plans[indexPath.row]
        print(plans[indexPath.row].title)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let plan = plans[indexPath.row]
        //var cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "detailsPlanCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "BestVotedViewCellTableViewCell") as! BestVotedViewCellTableViewCell
        
        cell.bonPlanViewImage.kf.setImage(with: plan.image,placeholder: UIImage(named:"bistro"))
        cell.planTitle.text = plan.title
        cell.categorieText.text = self.selectedCategory
        cell.categorie.image = UIImage(named: selectedCategory)
        cell.ratingView.rating = plan.rate
        self.plan_id = plan.id
        self.user_id =  UserDefaults.standard.integer(forKey: "user_id")

        cell.jaime.addTarget(self, action: #selector(relatedToLike),  for:   UIControl.Event.touchUpInside)
        
        return cell
        
    }
    
    
}

extension DashboardViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewCategories {
            return categories.count
        }
        return RecommandedPlans.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == collectionViewCategories {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell1", for: indexPath) as! CategoriesCollectionViewCell
            let categorie = categories[indexPath.row]
            
            
            cell.categorieImage.image = UIImage(named: categorie.nom)
            
            cell.categorieLabel.text = categorie.nom
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommandedPlanCell", for: indexPath)as! RecommandedPlanCell
            
            // Configure the cell
            
            let recommanded = RecommandedPlans[indexPath.row]
            
            
            cell.imagePlan.kf.setImage(with: recommanded.image)
            
            cell.planTitle.text = recommanded.title
            cell.categoryLabel.text = recommanded.title
            cell.categoryImage.image = UIImage(named: cell.categoryLabel.text!)
           // cell.configure(with: plan)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionViewCategories {
            
            let cell = collectionView.cellForItem(at: indexPath) as!  CategoriesCollectionViewCell
            
            if cell.categorieLabel.alpha == 0.25 {
                cell.categoryLabelAction(label: cell.categorieLabel,image: cell.categorieImage, alpha: 1)
                self.plans.removeAll()

                //call webservice here
                WebServiceBP.init().getPlansFromCategory(categorie: (cell.categorieLabel.text!)) { (response,isTrue) in
                    if isTrue{
                        print ("this is category clicked",cell.categorieLabel.text)
                        for rep in response{
                            let id = (rep as AnyObject).object(forKey: "id") as! Int
                            let title = (rep as AnyObject).object(forKey: "title") as! String
                            let longitude = ((rep as AnyObject).object(forKey: "longitude") as!NSString).doubleValue
                            let latitude = ((rep as AnyObject).object(forKey: "lattitude") as!NSString).doubleValue
                            
                            let region = (rep as AnyObject).object(forKey: "region") as! String
                            let description = (rep as AnyObject).object(forKey: "description") as! String
                            let adresse = (rep as AnyObject).object(forKey: "adresse") as! String
                            let rate = (rep as AnyObject).object(forKey: "rate") as! Double
                            let user_id = (rep as AnyObject).object(forKey: "user_id") as! Int
                            WebServiceBP.init().getImageForPlan(plan_id: id) { (response, isTrue) in
                                if isTrue{
                                    for rep in response{
                                        let imageURL = rep.object(forKey: "url") as! String
                                        let URL_IMAGE = URL(string:imageURL )
                                        let plan = Plan(image: URL_IMAGE!, description: description,adress:adresse, user_id: user_id, longitude: longitude, lattitude: latitude, region: region, id: id, title: title ,rate: rate)
                                        self.plans.append(plan)
                                        print("helloooo from icons",self.plans.count)
                                        self.bestVotedTableView.reloadData()
                                    }
                                }
                            }}
                        
                    }else
                    {
                        cell.categoryLabelAction(label: cell.categorieLabel,image: cell.categorieImage, alpha: 0.25)
                    //    self.plans.removeAll()
                        self.bestVotedTableView.reloadData()
                    }
                    
                }
                
                
            }
            
        }
            
        else {
            let cell = self.RecommandedPlanCollectionView.cellForItem(at: indexPath) as!RecommandedPlanCell
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageListScreen"
                ) as! ImageListScreen
            print ("recommanded plans count",plans.count)
            vc.plan = RecommandedPlans[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
