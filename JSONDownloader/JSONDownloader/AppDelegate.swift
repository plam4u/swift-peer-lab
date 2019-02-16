//
//  AppDelegate.swift
//  JSONDownloader
//
//  Created by Plamen Andreev on 25/01/2019.
//  Copyright © 2019 DMI Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    URLSession.shared.dataTask(with: URL(string: "https://randomuser.me/api/")!, completionHandler: { (data, response, error) in
      do {
        // Convert to dictionary where keys are of type String, and values are of any type
        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: Any]
        // Access specific key with value of type String
//        let str = json["key"] as! String
        print(json)
      } catch {
        // Something went wrong
      }
    }).resume()
    return true
  }
}

