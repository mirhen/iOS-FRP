//
//  Sequence+Util.swift
//  RxIssuesViewer
//
//  Created by Nikolas Burk on 22/11/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element == (key: String, value: String) {
  
  func toURLArguments() -> String {
    var result = ""
    for tuple in self {
      result += tuple.0 + "=" + tuple.1 + "&"
    }
    result = result.substring(to: result.index(before: result.endIndex))
    return result
  }
  
}
