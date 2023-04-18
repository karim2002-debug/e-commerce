//
//  AppDelegate.swift
//  e-commerce
//
//  Created by Macbook on 20/02/2023.
//

import UIKit

 @UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

     var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
    let window = UIWindow(frame: UIScreen.main.bounds)
        
 
    
        rootViewController()
        
        return true
    }
    
    
    func rootViewController(){
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let userDefults =   UserDefaults.standard.string(forKey: "login")
        let userOutDefults =   UserDefaults.standard.string(forKey: "out")

       
        // token == nil
        
//        if (userOutDefults == nil){
//            Token.Tokenalready = userOutDefults
//            let navigationController = UINavigationController(rootViewController:LoginViewController())
//            window.rootViewController = navigationController
//            window.makeKeyAndVisible()
//            self.window = window
//
//        }else if userOutDefults != nil{
//            Token.Tokenalready = userDefults
//            let navigationController = UINavigationController(rootViewController:MainViewController())
//            window.rootViewController = navigationController
//            window.makeKeyAndVisible()
//            self.window = window
//            
//        }
        
        let userPassword = UserDefaults.standard.string(forKey: "password")
            if userDefults == nil{
              //  Token.Tokenalready = userDefults
             //   Token.password = userPassword
                let navigationController = UINavigationController(rootViewController:LoginViewController())
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
                self.window = window
            }else{
                Token.password = userPassword
                Token.Tokenalready = userDefults
                let navigationController = UINavigationController(rootViewController:MainViewController())
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
                self.window = window

            }
       // }
        
       
        
//        
//          if userDefults != nil{ // token mawgod
//              Token.Tokenalready = userOutDefults
//              let navigationController = UINavigationController(rootViewController:MainViewController())
//              window.rootViewController = navigationController
//              window.makeKeyAndVisible()
//              self.window = window
//          }else{
//              //let navigationController = UINavigationController(rootViewController: SignUpViewController())
//              Token.Tokenalready = userOutDefults
//              let navigationController = UINavigationController(rootViewController:LoginViewController())
//              window.rootViewController = navigationController
//              window.makeKeyAndVisible()
//              self.window = window
//
//          }

    }

    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

