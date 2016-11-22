//
//  Issue.swift
//  RxIssuesViewer
//
//  Created by Nikolas Burk on 21/11/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import Foundation

struct Issue {
  let identifier: Int
  let title: String
  let postedBy: User
  let open: Bool
  let url: String
}
