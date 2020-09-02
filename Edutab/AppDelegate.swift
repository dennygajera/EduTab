//
//  AppDelegate.swift
//  Edutab
//
//  Created by Chirag Bhojani on 8/26/20.
//  Copyright © 2020 Chirag Bhojani. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigationController = UINavigationController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        var initialViewController: UIViewController = UIViewController()
        if AppPrefsManager.sharedInstance.isKeyExistInPreference(key: AppPrefsManager.sharedInstance.ISINTROFINISH) {
                    
                    if AppPrefsManager.sharedInstance.isKeyExistInPreference(key: AppPrefsManager.sharedInstance.USER) {
                        initialViewController = Storyboard.main.storyboard().instantiateViewController(withIdentifier:Identifier.home.rawValue) as! HomeVC
                    } else {
                        initialViewController = Storyboard.main.storyboard().instantiateViewController(withIdentifier:Identifier.ViewController.rawValue) as! ViewController
            }
            
                        
                    
                } else {
                    initialViewController = Storyboard.Introduction.storyboard().instantiateViewController(withIdentifier:Identifier.introduction.rawValue) as! IntroductionVC
                }
    
        navigationController = UINavigationController(rootViewController: initialViewController)
        navigationController.navigationBar.isHidden = true
        window?.rootViewController = navigationController
        return true
    }
}

