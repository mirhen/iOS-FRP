//
//  AppDelegate.swift
//  RxIssuesViewer
//
//  Created by Nikolas Burk on 21/11/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }
  
  // called after successful login on www.github.com
  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    guard let code = url.absoluteString.components(separatedBy: "=").last else {
      return false
    }
    print(#file.lastPathComponent()!, #line, #function, "received code: \(code)")
    RxGitHubAPI.authenticate(with: code)
    return false
  }

}

