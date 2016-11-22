//
//  String+Util.swift
//  RxIssuesViewer
//
//  Created by Nikolas Burk on 22/11/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import Foundation


extension String {
  
  func retrieveAccessToken() -> String? {
    let accessTokenParam = self.components(separatedBy: "&").first
    if let accessTokenParam = accessTokenParam {
      return accessTokenParam.components(separatedBy: "=").last
    }
    return nil
  }
  
  func lastPathComponent() -> String? {
    return components(separatedBy: "/").last
  }
  
}
