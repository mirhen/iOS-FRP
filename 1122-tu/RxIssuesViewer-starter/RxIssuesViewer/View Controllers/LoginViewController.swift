//
//  LoginViewController.swift
//  RxIssuesViewer
//
//  Created by Nikolas Burk on 21/11/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  @IBAction func loginButtonPressed() {
    let urlString = RxGitHubAPI.loginURL()
    if let url = URL(string: urlString) {
      UIApplication.shared.open(url, options: [:])
    }
  }
  
}
