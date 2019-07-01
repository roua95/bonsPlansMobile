//
//  WebServiceManager.swift
//  Pasha
//
//  Created by DEVLOPER on 05/08/2018.
//  Copyright © 2018 DEVLOPER. All rights reserved.
//


import UIKit
import Alamofire
import PKHUD

class WebServiceManager {
    
    static var instance: WebServiceManager!
    
    // SHARED INSTANCE
    class func sharedInstance() -> WebServiceManager {
        self.instance = (self.instance ?? WebServiceManager())
        return self.instance
    }
    
    // METHODS
    init() {
        print(#function)
    }
    
    //MARK: Login Web Service
    
    func login (_ email : String, password : String , completionHandler: @escaping (Bool) -> () )   {
        HUD.show(.progress)
        
        Alamofire.request(Constants.apiURL + Constants.login + "?email=\(email)&password=\(password)" as String, method: .post, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
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
}


func getExperties (completionHandler: @escaping ([NSDictionary],Bool) -> () ) {
    
    
    HUD.show(.progress)
    
    Alamofire.request(Constants.apiURL + Constants.expertise as String, method: .get, parameters: nil, encoding:  JSONEncoding.default, headers: nil)
        .responseJSON { response in
            
            switch response.result {
                
            case .success(let responseObject):
                print(responseObject)
                
                let responseDict = responseObject as! NSDictionary
                
                
                let status = responseDict.object(forKey: "status") as! Int
                print(responseDict)
                
                switch ("\(status)")   {
                    
                case Constants.codesuccess:
                    HUD.hide()
                    NSLog("Success")
                    let responseDictdata = responseDict.object(forKey: "data") as? [NSDictionary]
                    completionHandler(responseDictdata!,true)
                    break
                    
                default:
                    HUD.hide()
                    completionHandler([],false)
                    break
                    
                }
                
            case .failure(let error):
                HUD.hide()
                print(error)
                completionHandler([],false)
                
            }
    }
}


extension String: ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
}
