//
//  AppDelegate.swift
//  MovieBox
//
//  Created by Emrullah Hancer on 21.08.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
                window.rootViewController = UINavigationController(rootViewController: vc)
                window.makeKeyAndVisible()
            }
        }
        return true
    }

}

