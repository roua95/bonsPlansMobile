//
//  WebServiceBP.swift
//  BonPlan
//
//  Created by DEVLOPER on 05/03/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD

class WebServiceBP {
    static var instance: WebServiceBP!
    class func sharedInstance() -> WebServiceBP {
        self.instance = (self.instance ?? WebServiceBP())
        return self.instance
    }
    
    // METHODS
    init() {
        print(#function)
    }
    
    
    func login (_ email : String, password : String , completionHandler: @escaping (Bool) -> () )   {
        HUD.show(.progress)
        
        Alamofire.request(Constants.apiURL + Constants.login + "?email=\(email)&password=\(password)" as String, method: .post, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
            .responseJSON { response in
                
                print(response.result)
                switch response.result {
                    
                case .success(let responseObject):
                    print(responseObject)
                    
                    let responseDict = responseObject as! NSDictionary
                    
                    let token = responseDict.object(forKey: "message") as? String
                    var status = 400
                    if let tokenexist = token {
                        status = 200
                    }
                    switch ("\(status)")   {
                        
                    case Constants.codesuccess:
                        HUD.flash(.success)
                        NSLog("Success")
                        /** Saving credentials **/
                        /*
                         let userData = responseDict.object(forKey: "data") as! NSDictionary
                         UserDefaults.standard.set(userData.object(forKey: "id"), forKey: "id")
                         UserDefaults.standard.set(userData.object(forKey: "full_name"), forKey: "full_name")
                         UserDefaults.standard.set(userData.object(forKey: "email"), forKey: "email")
                         
                         UserDefaults.standard.set(userData.object(forKey: "token"), forKey: "token")
                         let country = userData.object(forKey: "country") as? NSDictionary
                         if let countryName = country?.object(forKey: "name"){
                         UserDefaults.standard.set(countryName, forKey: "country")
                         }
                         */
                        print("correct")
                        completionHandler(true)
                        break
                        
                    default:
                        HUD.flash(.error)
                        
                        completionHandler(false)
                        break
                        
                    }
                    
                case .failure(let error):
                    HUD.hide()
                    print(error)
                    
                }
        }}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    func signUp (prenom : String, nom : String, _ email : String, password : String ,confirmPassword : String, completionHandler: @escaping (Bool) -> () )   {
        HUD.show(.progress)
        
        Alamofire.request(Constants.apiURL + Constants.register as String, method: .post, parameters: ["prenom":prenom, "nom":nom,"email":email, "password":password, "confirmPassword":confirmPassword], encoding:  JSONEncoding.default, headers: nil)
            .responseJSON { response in
                
                print(response.result)
                switch response.result {
                    
                case .success(let responseObject):
                    print(responseObject)
                    
                    let responseDict = responseObject as! NSDictionary
                    
                    let token = responseDict.object(forKey: "token") as? String
                    var status = 400
                    if let tokenexist = token {
                        status = 200
                    }
                    switch ("\(status)")   {
                        
                    case Constants.codesuccess:
                        HUD.flash(.success)
                        NSLog("Success")
                        /** Saving credentials **/
                        /*
                         let userData = responseDict.object(forKey: "data") as! NSDictionary
                         UserDefaults.standard.set(userData.object(forKey: "id"), forKey: "id")
                         UserDefaults.standard.set(userData.object(forKey: "full_name"), forKey: "full_name")
                         UserDefaults.standard.set(userData.object(forKey: "email"), forKey: "email")
                         
                         UserDefaults.standard.set(userData.object(forKey: "token"), forKey: "token")
                         let country = userData.object(forKey: "country") as? NSDictionary
                         if let countryName = country?.object(forKey: "name"){
                         UserDefaults.standard.set(countryName, forKey: "country")
                         }
                         */
                        completionHandler(true)
                        break
                        
                    default:
                        HUD.flash(.error)
                        
                        completionHandler(false)
                        break
                        
                    }
                    
                case .failure(let error):
                    HUD.hide()
                    print(error)
                    
                }
        }}


    func signUpSocialMedia (firstName : String, lastName : String, _ email : String, provider : String ,provider_id : String, completionHandler: @escaping (Bool) -> () )   {
        HUD.show(.progress)
        
        Alamofire.request(Constants.apiURL + Constants.login + "?firstName=\(firstName)&?LastName=\(lastName)&?email=\(email)&provider=\(provider)?provider_id=\(provider_id)&" as String, method: .post, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
            .responseJSON { response in
                
                print(response.result)
                switch response.result {
                    
                case .success(let responseObject):
                    print(responseObject)
                    
                    let responseDict = responseObject as! NSDictionary
                    
                    let token = responseDict.object(forKey: "token") as? String
                    var status = 400
                    if let tokenexist = token {
                        status = 200
                    }
                    switch ("\(status)")   {
                        
                    case Constants.codesuccess:
                        HUD.flash(.success)
                        NSLog("Success")
                       
                        completionHandler(true)
                        break
                        
                    default:
                        HUD.flash(.error)
                        
                        completionHandler(false)
                        break
                        
                    }
                    
                case .failure(let error):
                    HUD.hide()
                    print(error)
                    
                }
        }}

    func signInSocialMedia ( _ email : String, provider : String ,provider_id : String, completionHandler: @escaping (Bool) -> () )   {
        HUD.show(.progress)
        
        Alamofire.request(Constants.apiURL + Constants.login + "?email=\(email)&provider=\(provider)?provider_id=\(provider_id)&" as String, method: .post, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
            .responseJSON { response in
                
                print(response.result)
                switch response.result {
                    
                case .success(let responseObject):
                    print(responseObject)
                    
                    let responseDict = responseObject as! NSDictionary
                    
                    let token = responseDict.object(forKey: "token") as? String
                    var status = 400
                    if let tokenexist = token {
                        status = 200
                    }
                    switch ("\(status)")   {
                        
                    case Constants.codesuccess:
                        HUD.flash(.success)
                        NSLog("Success")
                        
                        completionHandler(true)
                        break
                        
                    default:
                        HUD.flash(.error)
                        
                        completionHandler(false)
                        break
                        
                    }
                    
                case .failure(let error):
                    HUD.hide()
                    print(error)
                    
                }
        }}
    
    ////////////webservices for dashboard********Categories*****
    func getCategories(completionHandler: @escaping ([NSDictionary], Bool) -> () )   {
        Alamofire.request(Constants.apiURL + Constants.category + "/index" as String, method: .get, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
            .responseJSON { response in
                let array = response.result
                print ("Hello \(array)")
                switch response.result {
                    
                case .success(let responseObject):
                    print(responseObject)
                    
                
                    let responseDict = responseObject as! NSDictionary
                    let data = responseDict.object(forKey: "data") as! [NSDictionary]
                    
                    completionHandler(data, true)
                case .failure(_):
                    print ("error")
                    completionHandler([],false)

                }}
    }
    func AddPlan(title : String, adress : String ,region : String,latitude : Double, longitude : Double,description : String,user_id : Int,image :String,rate: Double, completionHandler: @escaping (NSDictionary, Bool) -> () )   {
        //HUD.show(.progress)
        Alamofire.request(Constants.apiURL + Constants.plan + "/create" + "?longitude=\(longitude)&lattitude=\(latitude)&user_id=\(user_id)&region=\(region)&adresse=\(adress)&rate=\(rate)&title=\(title)&description=\(description)" as String, method: .post, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
            .responseJSON { response in
            
                print(response.result)
                switch response.result {
                case .success(let responseObject):
                print(responseObject)
                
                let responseDict = responseObject as! NSDictionary
                
                
                HUD.flash(.success)
                NSLog("Success")
                let responseDictdata = responseDict.object(forKey: "data") as? NSDictionary
                completionHandler(responseDictdata!,true)
                
                case .failure(let error):
                //HUD.hide()
                print(error)
                completionHandler([:],false)
                HUD.flash(.error)

                }}

        }
    
    func showPlans(completionHandler: @escaping ([NSDictionary], Bool) -> () )   {
       // HUD.show(.progress)
        Alamofire.request(Constants.apiURL + Constants.plan + "/index" as String, method: .post, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
            .responseJSON { response in
                
                print(response.result)
                switch response.result {
                case .success(let responseObject):
                    print(responseObject)
                    
                    let responseDict = responseObject as! NSDictionary
                    
                    
                //    HUD.hide()
                    NSLog("Success")
                    let responseDictdata = responseDict.object(forKey: "data") as? [NSDictionary]
                    completionHandler(responseDictdata!,true)
                    
                case .failure(let error):
                   // HUD.hide()
                    print(error)
                    completionHandler([],false)
                    
                }}
        
    }
    
    func getPlanCategory(planId : Int){
        Alamofire.request(Constants.apiURL + Constants.plan + "/findCategory" as String, method: .get, parameters: nil, encoding:  JSONEncoding.default, headers: nil)

    }
    func mostRatedPlans(){
        Alamofire.request(Constants.apiURL + Constants.plan + "/mostRated" as String, method: .get, parameters: nil, encoding:  JSONEncoding.default, headers: nil)

    }
    func addToFavorites(user_id : Int,plan_id:Int, completionHandler: @escaping (NSDictionary, Bool) -> () )   {
        Alamofire.request(Constants.apiURL + Constants.plan + "/addToFavorites"+"?user_id=\(user_id)&plan_id=\(plan_id)&"as String, method: .post, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
        .responseJSON { response in
            
            print(response.result)
            switch response.result {
            case .success(let responseObject):
                print("add to favorite response")
                print(responseObject)
                
                let responseDict = responseObject as! NSDictionary
                
                
                //    HUD.hide()
                NSLog("Success")
                let responseDictdata = responseDict.object(forKey: "data") as? NSDictionary
                completionHandler(responseDictdata!,true)
                
            case .failure(let error):
                // HUD.hide()
                print(error)
                completionHandler([:],false)
                
            }}
        
    }
    func removeFromFavorites(user_id : Int,plan_id:Int, completionHandler: @escaping (NSDictionary, Bool) -> () )   {
        Alamofire.request(Constants.apiURL + Constants.plan + "/removeFromFavorites"+"?user_id=\(user_id)&plan_id=\(plan_id)&"as String, method: .post, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
            .responseJSON { response in
                
                print(response.result)
                switch response.result {
                case .success(let responseObject):
                    print("remove from favorite response")
                    print(responseObject)
                    
                    let responseDict = responseObject as! NSDictionary
                    
                    
                    //    HUD.hide()
                    NSLog("Success")
                    let responseDictdata = responseDict.object(forKey: "data") as? NSDictionary
                    completionHandler(responseDictdata!,true)
                    
                case .failure(let error):
                    // HUD.hide()
                    print(error)
                    completionHandler([:],false)
                    
                }}
    }
    func ratePlan(user_id : Int,plan_id:Int,rate: Int ,completionHandler: @escaping (String,Bool) -> () )   {
        Alamofire.request(Constants.apiURL + Constants.plan + "/ratePlan?user_id=\(user_id)&plan_id=\(plan_id)&rate=\(rate)"as String, method: .post, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
            .responseString { response in
                
                switch response.result {
                case .success(let responseObject):
                    print("rate plan response")
                        HUD.hide()
                    NSLog("Success")
                    completionHandler("succeded rate",true)
                    
                case .failure(let error):
                     HUD.hide()
                    print(error)
                    completionHandler("failed rate",false)
                    
                }}
        
    }
    func PlansFavoris(){
        //mostVoted By user-id
    }
    func profile(user_id : Int){
        
    }
    func showComments(plan_id : Int,        completionHandler: @escaping ([NSDictionary],Bool) -> () ){

        Alamofire.request(Constants.apiURL + Constants.comment + "/index?plan_id=\(plan_id)&"as String, method: .get, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
            .responseJSON { response in
                print ("show comments response")
                print(response.result)
                switch response.result {
                case .success(let responseObject):
                    print(responseObject)
                    
                    let responseDict = responseObject as! NSDictionary
                    let data = responseDict.object(forKey: "data") as! [NSDictionary]
                    
                    
                    HUD.hide()
                    NSLog("Success")
                    
                    completionHandler(data,true)
                    
                case .failure(let error):
                    HUD.hide()
                    print(error)
                    completionHandler([],false)
                    
                }}
    }
        
    
    func addComment
        (user_id : Int, plan_id: Int, text_comment: String, completionHandler: @escaping (Bool) -> () ){
            Alamofire.request(Constants.apiURL + Constants.comment + "/create?user_id=\(user_id)&plan_id=\(plan_id)&text=\(text_comment)"as String, method: .post, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
                .responseData { response in
                
                print(response.result)
                switch response.result {
                case .success(let responseObject):
                    print(responseObject)
                    
                    let responseDict = responseObject as Data
                   /* let data = (responseDict as NSDictionary).object(forKey: "data") as! NSDictionary
                    */
                    HUD.hide()
                    NSLog("Success")
                    
                    completionHandler(true)
                    
                case .failure(let error):
                    HUD.hide()
                    print(error)
                    completionHandler(false)
                    
                }}
    
    
    
    func getPlansByCategorie
        (category: String, completionHandler: @escaping ([NSDictionary],Bool) -> () ){
            Alamofire.request(Constants.apiURL + Constants.category + "/getPlansByCategory"as String, method: .post, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
                .responseJSON { response in
                    
                    print(response.result)
                    switch response.result {
                    case .success(let responseObject):
                        print(responseObject)
                        
                        let responseDict = responseObject as! NSDictionary
                        let data = responseDict.object(forKey: "data") as! [NSDictionary]
                        
                        
                        HUD.hide()
                        NSLog("Success")
                        
                        completionHandler(data,true)
                        
                    case .failure(let error):
                        HUD.hide()
                        print(error)
                        completionHandler([],false)
                        
                    }}
            
    }
}
   
   
    func likePlan
        (plan_id: Int,user_id:Int,completionHandler:@escaping (Bool)-> () ){
        Alamofire.request(Constants.apiURL + Constants.plan + "/likePlan"+"?user_id=\(user_id)&plan_id=\(plan_id)&"as String, method: .post, parameters: nil, encoding:  URLEncoding.default, headers: nil)
            .responseData { response in
                print ("this is likePlan response")
                print(response.result)
                switch response.result {
                case .success(let responseObject):
                    
                    let responseDict = responseObject as  Data
                    
                    
                    HUD.hide()
                    NSLog("Success")
                    
                    completionHandler(true)
                    
                case .failure(let error):
                    HUD.hide()
                    print(error)
                    completionHandler(false)
                    
                }}
        
    }
    func likesNumber
        (plan_id: Int,completionHandler: @escaping (String) -> ()){
        Alamofire.request(Constants.apiURL + Constants.plan + "/likesNumber/"+"?plan_id=\(plan_id)&"as String, method: .get, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
        .responseJSON { response in
        print ("this is likesNumber response")
        print(response.result)
        switch response.result {
        case .success(let responseObject):
        print(responseObject)
        
        //let responseDict = responseObject as! String
        let data = responseObject as! NSDictionary

         let responseDict = data.object(forKey: "data") as! String
        
        HUD.hide()
        NSLog("Success")
        
        completionHandler(responseDict)
        
        case .failure(let error):
        HUD.hide()
        print(error)
        //completionHandler([responseDict])
        
        }}
        
}
    
    
    func getImageForPlan
        (plan_id: Int,completionHandler: @escaping ([NSDictionary], Bool) -> () )   {
        Alamofire.request(Constants.apiURL + Constants.image + "/show/"+"?plan_id=\(plan_id)&"as String, method:.get, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
            .responseJSON { response in
                
                print(response.result)
                switch response.result {
                case .success(let responseObject):
                    print(responseObject)
                    
                    let responseDict = responseObject as! NSDictionary
                    let data = responseDict.object(forKey: "data") as! [NSDictionary]
                    completionHandler(data, true)
                    
                    HUD.hide()
                    NSLog("Success")
                    
                    
                case .failure(let error):
                    HUD.hide()
                    print(error)
                completionHandler([],false)
                    
                }}
        
    }
    
    
    func getPlansFromCategory
        (categorie: String,completionHandler: @escaping ([NSDictionary],Bool) -> () )   {
        Alamofire.request(Constants.apiURL + Constants.plan + "/getPlansByCategory/"+"?categorie=\(categorie)&"as String, method:.get, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
            .responseJSON { response in
                print("plans sorted by category")
                print(response.result)
                switch response.result {
                case .success(let responseObject):
                    print(responseObject)
                    
                    let responseDict = responseObject as! [NSDictionary]
                    
                    //let data = responseDict.object(forKey: "data") as! [NSDictionary]
                        //print(index,":",element)
                        completionHandler(responseDict, true)
                    
                    HUD.hide()
                    NSLog("Success")
                    
                case .failure(let error):
                    HUD.hide()
                    print(error)
                    completionHandler([],false)

                }}
        
    }
    
    
    func getPlanLikes
      /*  (plan_id: Int,completionHandler: @escaping ([NSDictionary], Bool) -> () )   {
        Alamofire.request(Constants.apiURL + Constants.plan + "/likesNumber/"+"?plan_id=\(plan_id)&"as Int, method:.get, parameters: nil, encoding:  JSONEncoding.default, headers: nil)*/
        (plan_id: Int,completionHandler: @escaping (String, Bool) -> () )   {
            Alamofire.request(Constants.apiURL + Constants.plan + "/likesNumber/"+"?plan_id=\(plan_id)&"as String, method:.get, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
                .responseJSON { response in
                
                print(response.result)
                switch response.result {
                case .success(let responseObject):
                    print(responseObject)
                    
                    let responseDict = responseObject as! NSDictionary
                    let data = responseDict.object(forKey: "data") as! String
                    //let data = responseObject as! String
                    completionHandler(data, true)
                    
                    HUD.hide()
                    NSLog("Success")
                    
                case .failure(let error):
                    HUD.hide()
                    print(error)
                    completionHandler("",false)
                    
                }}
    }
   
    func researchPlanByName
        (title: String,completionHandler: @escaping ([NSDictionary],Bool) -> () )
        {
            Alamofire.request(Constants.apiURL + Constants.plan + "/show/"+"?title=\(title)"as String, method:.get, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
                .responseJSON { response in
                    print(response.result)
                    switch response.result {
                    case .success(let responseObject):
                        print("researchByName")
                        print(responseObject)
                        
                        let responseDict = responseObject as! NSDictionary
                        let data = responseDict.object(forKey: "data") as! [NSDictionary]
                            completionHandler(data,true)
                            
                            HUD.hide()
                            NSLog("Success")
                        
                    case .failure(let error):
                        HUD.hide()
                        print(error)
                        completionHandler([],false)
                        
                    }}
}

    
    func researchPlanByRegion
        (region: String,completionHandler: @escaping ([NSDictionary],Bool) -> () )
        {
            
            Alamofire.request(Constants.apiURL + Constants.plan + "/getPlansByRegion/"+"?region=\(region)"as String, method:.get, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
                .responseJSON { response in
                    print("researchByRegion")

                    print(response.result)
                    switch response.result {
                    case .success(let responseObject):
                        print(responseObject)
                        
                        let responseDict = responseObject as!NSDictionary
                        let data = responseDict.object(forKey: "data") as! [NSDictionary]
                        completionHandler(data,true)
                        
                        HUD.hide()
                        NSLog("Success")
                        
                    case .failure(let error):
                        HUD.hide()
                        print(error)
                        completionHandler([],false)
                        
                    }}
        }
    
    
    func getRecommandedPlans
        (min: Int,completionHandler: @escaping ([NSDictionary],Bool) -> () )
    {
        Alamofire.request(Constants.apiURL + Constants.plan + "/getRecommandedPlans?min=\(min)&"as String, method:.get, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
            .responseJSON { response in
                print(response.result)
                switch response.result {
                case .success(let responseObject):
                    print(responseObject)
                    
                    let responseDict = responseObject as!NSDictionary
                    let data = responseDict.object(forKey: "data") as! [NSDictionary]
                    completionHandler(data,true)
                    
                    HUD.hide()
                    NSLog("Success")
                    
                case .failure(let error):
                    HUD.hide()
                    print(error)
                    completionHandler([],false)
                    
                }}
    }
    func createProfile(name : String,tel:Int,address: String,email: String, password :String ,completionHandler: @escaping (String,Bool) -> () )   {
        Alamofire.request(Constants.apiURL + "profile/create?name=\(name)&tel=\(tel)&address=\(address)&password=\(password)"as String, method: .post, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
            .responseString { response in
                
                switch response.result {
                case .success(let responseObject):
                    print("profile response")
                    HUD.flash(.success)
                    NSLog("Success")
                    completionHandler("succeded rate",true)
                    
                case .failure(let error):
                    HUD.hide()
                    print(error)
                    completionHandler("failed rate",false)
                    
                }}
        
    }
    func getFavoritedPlans
        (user_id: Int,completionHandler: @escaping ([NSDictionary],Bool) -> () )
    {
        Alamofire.request(Constants.apiURL + Constants.plan + "/getFavoritePlans?user_id=\(user_id)&"as String, method:.get, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
            .responseJSON { response in
                print(response.result)
                switch response.result {
                case .success(let responseObject):
                    print(responseObject)
                    
                    let responseDict = responseObject as!NSDictionary
                    let data = responseDict.object(forKey: "data") as! [NSDictionary]
                    completionHandler(data,true)
                    
                    HUD.hide()
                    NSLog("Success")
                    
                case .failure(let error):
                    HUD.hide()
                    print(error)
                    completionHandler([],false)
                    
                }}
    }
}
