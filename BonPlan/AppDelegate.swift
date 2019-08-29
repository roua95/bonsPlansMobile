//
//  AppDelegate.swift
//  BonPlan
//
//  Created by DEVLOPER on 22/02/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FacebookCore
import FacebookLogin
import FBSDKLoginKit
import GoogleSignIn
import GoogleMaps
import GooglePlaces
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, FBSDKLoginButtonDelegate {
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged in")
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
        
    }
    
    
    var window: UIWindow?
    
    let notificationDelegate = SampleNotificationDelegate()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after applicationlaunch.
        
        UITabBar.appearance().tintColor = UIColor.blue
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        //SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        // Initialize sign-in
        GIDSignIn.sharedInstance().clientID = "475251482142-5jdlt69e68b1nh7up9qm2d6aj9if7o9f.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        GMSServices.provideAPIKey("AIzaSyBwjdKl-_MT0fwx-z6kWC3SyTriR22qo8Y")
        GMSPlacesClient.provideAPIKey("AIzaSyBwjdKl-_MT0fwx-z6kWC3SyTriR22qo8Y")
        FirebaseApp.configure()
        
        
        GMSPlacesClient.provideAPIKey("AIzaSyAUfZJYT647g0wmzyZbw0o5uEp45GV9sOE")
        
        //registerForPushNotifications()
        ///added this part
        //setCategories()
        /* UNUserNotificationCenter.current().delegate = self as! UNUserNotificationCenterDelegate
         UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {(granted,error) in
         if granted{
         application.registerForRemoteNotifications()
         }
         })
         */
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL?,
                                                 sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        AppEventsLogger.activate(application)
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                [weak self] granted, error in
                
                print("Permission granted: \(granted)")
                guard granted else { return }
                self?.getNotificationSettings()
        }
    }
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
        ) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    func configureNotification() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            center.delegate = notificationDelegate
            let openAction = UNNotificationAction(identifier: "OpenNotification", title: NSLocalizedString("Abrir", comment: ""), options: UNNotificationActionOptions.foreground)
            let deafultCategory = UNNotificationCategory(identifier: "CustomSamplePush", actions: [openAction], intentIdentifiers: [], options: [])
            center.setNotificationCategories(Set([deafultCategory]))
        } else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func setCategories(){
        let snoozeAction = UNNotificationAction(
            identifier: "snooze.action",
            title: "Snooze",
            options: [])
        let pizzaCategory = UNNotificationCategory(
            identifier: "pizza.category",
            actions: [snoozeAction],
            intentIdentifiers: [],
            options: [])
        UNUserNotificationCenter.current().setNotificationCategories(
            [pizzaCategory])
    }
    
    
    
    
    func tokenString(_ deviceToken:Data) -> String{
        //code to make a token string
        let bytes = [UInt8](deviceToken)
        var token = ""
        for byte in bytes{
            token += String(format: "%02x",byte)
        }
        return token
    }
    
    
    
    //MARK: - Delegates for Notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let action = response.actionIdentifier
        let request = response.notification.request
        let content = request.content
        if action == "snooze.action"{
            let snoozeTrigger = UNTimeIntervalNotificationTrigger(
                timeInterval: 5.0,
                repeats: false)
            let snoozeRequest = UNNotificationRequest(
                identifier: "pizza.snooze",
                content: content,
                trigger: snoozeTrigger)
            center.add(snoozeRequest){
                (error) in
                if error != nil {
                    print("Snooze Request Error: \(error?.localizedDescription)")
                }
            }
        }
        completionHandler()
    }
}



