//
//  AppDelegate.swift
//  lessson 2_1
//
//  Created by Alexander Myskin on 11.06.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//


import UIKit
//import FirebaseCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(getDocumentsDirectory())
       // FirebaseApp.configure()
        return true
    }
    
    func getDocumentsDirectory() -> URL {
          let paths = FileManager.default.urls(
              for: .documentDirectory,
              in: .userDomainMask
          )
          return paths[0]
      }

}

