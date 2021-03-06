//
//  AppDelegate.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Firebase has to be initialized before showing AuthOptionsViewController.
        // Otherwise it would crash becuase AuthOptionsViewController uses FirebaseAuth
        FirebaseApp.configure()

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = AuthOptionsViewController()
        self.window!.makeKeyAndVisible()

        return true
    }
}

