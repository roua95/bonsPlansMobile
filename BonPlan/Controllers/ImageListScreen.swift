//
//  ImageListScreen.swift
//  BonPlan
//
//  Created by DEVLOPER on 25/03/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit
import GoogleMaps
import Social
import MapKit
import Kingfisher
import Cosmos

class ImageListScreen: UIViewController,GMSMapViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var URL_IMAGE = URL(string: "https://www.apple.com")
    let user_id = UserDefaults.standard.integer(forKey: "user_id")
    
    @objc func fav() {
        WebServiceBP.init().addToFavorites(user_id: 1, plan_id: plan.id) { (response,isTrue) in
            
                let id = response.object(forKey: "id") as! Int
                let title = response.object(forKey: "title") as! String
                let longitude = response.object(forKey: "longitude") as! String
                let latitude = response.object(forKey: "lattitude") as! String
                
                let region = response.object(forKey: "region") as! String
                let description = response.object(forKey: "description") as! String
                let adresse = response.object(forKey: "adresse") as! String
                let rate = response.object(forKey: "rate") as! Double
                let user_id = response.object(forKey: "user_id") as! Int
                WebServiceBP.init().getImageForPlan(plan_id: id) { (response, isTrue) in
                    if isTrue{
                        for rep in response{
                            let imageURL = rep.object(forKey: "url") as! String
                            let URL_IMAGE = URL(string:imageURL )
                            let plan = Plan(image: URL_IMAGE!, description: description,adress:adresse, user_id: user_id, longitude: Double(longitude) ?? 0.0, lattitude: Double(latitude) ?? 0.0, region: region, id: id, title: title ,rate: rate)
                            self.favorited.append(plan)
                            print("helloooo from icons",self.favorited.count)
                            
                        }
                    }
                }
        }
    }
    
    
    var plans: [Plan] = []
    var favorited: [Plan] = []
    var rate: Int = 5
    var plan :Plan = Plan(image:URL(string: "https://assets3.thrillist.com/v1/image/2797371/size/tmg-article_default_mobile.jpg")!,description: "café Resto",adress:"sousse", user_id: 2, longitude: 35.838662, lattitude: 10.593509, region: "sousse", id: 1, title: "toscana", rate: 4)
    var comments: [Commentaire] = []
    var text : String = " "
    var image_url : String = ""
    
    var map : GMSMapView?
    
    @IBOutlet weak var commentaire: SkyFloatingLabelTextField!
    @IBOutlet weak var envoyerBtn: UIButtonX!
    @IBOutlet weak var subViewPopoup: UIView!
    
    @IBAction func envoyerBTnAction(_ sender: UIButtonX) {
        commentCreate(user_id: self.user_id, plan_id: plan.id, text_comment: self.commentaire.text!)
        print(self.commentaire.text)
    }
    @IBOutlet weak var popup: UIView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        showComments()
        
        plans.append(self.plan)
        print("this is the plan longitude")
        print(plan.longitude)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        print("this is user_id",user_id)
        WebServiceBP.init().getImageForPlan(plan_id: plan.id) { (response, isTrue) in
            if isTrue{
                // self.plans.removeAll()
                for rep in response{
                    self.image_url = rep.object(forKey: "url") as! String
                    let cell1 = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? detailsPlanCell
                    //   cell1!.planImage.kf.setImage(with: URL(string: self.image_url))
                    // cell1?.comment_text.text = self.plan.description
                    
                    
                }}}
        map = GMSMapView()
        let cell = self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? GoogleMapTableViewCell
        let camera = GMSCameraPosition.camera(withLatitude: plan.lattitude, longitude: plan.longitude, zoom: 16.0)
        map = GMSMapView.map(withFrame: cell?.mapView.bounds ?? self.view.bounds, camera: camera)
        
        map!.isMyLocationEnabled = true
        map!.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: plan.lattitude, longitude: plan.longitude), zoom: 16.0, bearing: 0, viewingAngle: 0)
        
        map!.delegate = self
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: plan.lattitude,longitude:plan.longitude)
        marker.title = plan.title
        marker.snippet = plan.region
        marker.map = map
        tableView.reloadData()
        
      /*  let cell3 = self.tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! CommentsCell
        cell3.avis.text = "les avis"
        cell3.tableView.delegate = self
        */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        subViewPopoup.isHidden = true
        popup.isHidden = true
        subViewPopoup.tag = 10
        self.view.addSubview(subViewPopoup)
        let aSelector : Selector = #selector(ImageListScreen.touchesBegan as (ImageListScreen) -> () -> ())
        let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
        subViewPopoup.addGestureRecognizer(tapGesture)
        
    }
    
    func commentCreate(user_id: Int, plan_id: Int, text_comment: String){
        WebServiceBP.init().addComment(user_id: user_id, plan_id: plan_id, text_comment: text_comment) { (isTrue) in
            if isTrue{
                print("comment added")
            }
        }
        
    }
    
    @objc func addToFavorite(){
        WebServiceBP.init().addToFavorites(user_id: self.user_id, plan_id: plan.id) { (response,isTrue) in
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
                            self.favorited.append(plan)
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationsViewController")
                        
                            print("helloooo from icons",self.favorited.count)
                           
                        }
                    }
        }}
        }
    }

    @objc func ratePlan(){
        WebServiceBP.init().ratePlan(user_id: self.user_id, plan_id: plan.id, rate: self.rate) { (response,isTrue)  in
            if isTrue {print("plan rated")}
    }
        }
    

    @objc func partager(sender: UIButton){
        let buttonTag = sender.tag
        
        
         let firstActivityItem = "Text you want"
         let secondActivityItem : NSURL = NSURL(string: "http//:urlyouwant")!
         // If you want to put an image
         let image : UIImage = UIImage(named: "like")!
         
         let activityViewController : UIActivityViewController = UIActivityViewController(
         activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
         
         // This lines is for the popover you need to show in iPad
         activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
         
         // This line remove the arrow of the popover to show in iPad
         activityViewController.popoverPresentationController?.permittedArrowDirections = []
         activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
         
         // Anything you want to exclude
         activityViewController.excludedActivityTypes = [
         UIActivity.ActivityType.postToWeibo,
         UIActivity.ActivityType.print,
         UIActivity.ActivityType.assignToContact,
         UIActivity.ActivityType.saveToCameraRoll,
         UIActivity.ActivityType.addToReadingList,
         UIActivity.ActivityType.postToFlickr,
         UIActivity.ActivityType.postToVimeo,
         UIActivity.ActivityType.postToTencentWeibo
         ]
         
         self.present(activityViewController, animated: true, completion: nil)
         
         }
    /*
        let alert = UIAlertController(title: "Share", message: "Share the poem of the day!", preferredStyle: .actionSheet)
        
        //First action
        let actionOne = UIAlertAction(title: "Share on Facebook", style: .default) { (action) in
            
            //Checking if user is connected to Facebook
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook)
            {
                let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "detailsPlanCell") as! detailsPlanCell
                
                post.setInitialText(cell.comment_text.text)
                post.add(cell.planImage.image)
                self.present(post, animated: true, completion: nil)
                
            } else {self.showAlert(service: "Facebook")}
        }
        
        //Second action
        let actionTwo = UIAlertAction(title: "Share on Twitter", style: .default) { (action) in
            
            //Checking if user is connected to Facebook
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter)
            {
                let post = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "detailsPlanCell") as! detailsPlanCell
                
                post.setInitialText(cell.comment_text.text)
                post.add(cell.planImage.image)
                
                self.present(post, animated: true, completion: nil)
                
            } else {self.showAlert(service: "Twitter")}
        }
        
        let actionThree = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        //Add action to action sheet
        alert.addAction(actionOne)
        alert.addAction(actionTwo)
        alert.addAction(actionThree)
        
        //Present alert
        self.present(alert, animated: true, completion: nil)
 
    }*/
    func showAlert(service:String)
    {
        let alert = UIAlertController(title: "Error", message: "You are not connected to \(service)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
        
extension ImageListScreen: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    @objc func touchesBegan() {
        self.subViewPopoup.isHidden = true
    }
    @objc func comment(sender: UIButton){
        let buttonTag = sender.tag
        subViewPopoup.isHidden = false
        popup.isHidden = false
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            
            
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "detailsPlanCell") as! detailsPlanCell
                cell.commenter_btn.addTarget(self, action: #selector(comment(sender:)), for: .touchUpInside)
                cell.partager_btn.addTarget(self, action: #selector(partager(sender:)), for: .touchUpInside)
                cell.planImage.kf.setImage(with: plan.image)
                cell.comment_text.text = self.plan.description
                cell.addFav.addTarget(self, action: #selector(fav), for: .touchUpInside)
              //  cell.rate(self, action: #selector(ratePlan), for: .valueChanged)
                cell.rate.didFinishTouchingCosmos = { rating in
                    self.rate = Int(rating)
                    self.ratePlan()
                    print ("rating is", Int(rating))

                }
                

                return cell
                
            }else if indexPath.row == 1 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "mapCell") as! GoogleMapTableViewCell
                if let mapView = map {
                    cell.mapView.addSubview(mapView)
                    
                }
                
                return cell
            }
            else {
                self.tableView.register(CommentsCell.self, forCellReuseIdentifier: "CommentsCell")
                
                let cell = tableView.cellForRow(at: indexPath) as! CommentsCell
                let cellComment = cell.tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
                
                let commentaire = comments[indexPath.row]
                print("this is comments table content")
                print (comments)
                cellComment.commentText.text = "HELLO"
                return cellComment
            }
        }
        return tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
    }
    
    func showComments(){
        self.comments.removeAll()
        WebServiceBP.init().showComments(plan_id: 1) { (response, isTrue) in
            if isTrue{
                for rep in response{
                    let user_id = rep.object(forKey: "user_id") as! Int
                    let plan_id = rep.object(forKey: "plan_id") as! Int
                    let text = rep.object(forKey: "text") as! String
                    
                    self.comments.append(Commentaire(user_id: user_id, plan_id: plan_id, text: text))
                    
                }
                 self.tableView.reloadData()
            }
            
        }
        
    }
    
}

extension ImageListScreen: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldReceive touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }
    
    
}

