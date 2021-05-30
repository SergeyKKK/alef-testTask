//
//  AppDelegate.swift
//  alefTZ
//
//  Created by Serega Kushnarev on 28.05.2021.
//

import UIKit

// MARK: - AppDelegate

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Public property
    
    var window: UIWindow?
    
    // MARK: - Public methods
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let userInformationController = UserInformationController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = userInformationController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

