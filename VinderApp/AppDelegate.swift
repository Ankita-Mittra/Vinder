//
//  AppDelegate.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initial Setup

        if userDefault.value(forKey: USER_DEFAULT_firstTimeInstallApp_Key) as? Bool ?? false{
            self.navigateToRightScreen()
            
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let MainView = (storyboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.onboardingVC.rawValue) as? OnboardingVC
            )!
            let navController = UINavigationController.init(rootViewController: MainView)
            self.window?.rootViewController = navController
        }
        return true
    }

    func navigateToRightScreen(){
        
        if let authToken: String = userDefault.value(forKey: USER_DEFAULT_token_Key) as? String{
            print("auth token...", authToken)
            if authToken != emptyStr{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let MainView = (storyboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.tabBarVC.rawValue) as? TabBarVC)!
                let navController = UINavigationController.init(rootViewController: MainView)
                self.window?.rootViewController = navController
            }else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let MainView = (storyboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.initialVC.rawValue) as? InitialVC)!
                let navController = UINavigationController.init(rootViewController: MainView)
                self.window?.rootViewController = navController
            }
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let MainView = (storyboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.initialVC.rawValue) as? InitialVC)!
            let navController = UINavigationController.init(rootViewController: MainView)
            self.window?.rootViewController = navController
        }
    }
    
//    func navigateToRightScreen(){
//        let userId:String = UserDefaultsToStoreUserInfo.getUserID()
//        if userId != emptyStr{
//
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let MainView = (storyboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.initialVC.rawValue) as? TabBarVC)!
//
//            let navController = UINavigationController.init(rootViewController: MainView)
//
//            self.window?.rootViewController = navController
//
////            let navController:UINavigationController = (self.window?.rootViewController as? UINavigationController)!
////            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
////            let otherVCObj = mainStoryboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.initialVC.rawValue) as! InitialVC
////            navController.pushViewController(otherVCObj, animated: true)
//        }else{
//
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let MainView = storyboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.initialVC.rawValue) as? TabBarVC
//
//            let navController = UINavigationController.init(rootViewController: MainView!)
//
//            self.window?.rootViewController = navController
//
////            let navController:UINavigationController = (self.window?.rootViewController as? UINavigationController)!
////            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
////            let otherVCObj = mainStoryboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.tabBarVC.rawValue) as! InitialVC
////            navController.pushViewController(otherVCObj, animated: true)
//        }
//    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "VinderApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

