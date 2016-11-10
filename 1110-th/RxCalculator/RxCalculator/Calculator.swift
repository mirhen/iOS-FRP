//
//  Calculator.swift
//  RxCalculator
//
//  Created by Nikolas Burk on 09/11/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import Foundation


class Calculator {
  
  enum Operation: Int { // rawValues of type Int so it goes nicely with the segmented control
    case addition
    case subtraction
  }
  
  let signs = ["+", "-"]
  

  // MARK: Operations
  
  func add(a: Int, b: Int) -> Int {
    return a+b
  }
  
  func subtract(a: Int, b: Int) -> Int {
    return a-b
  }
  
  
  // MARK: Helpers
  
  func sign(for operation: Operation) -> String {
    return signs[operation.rawValue]
  }
  
}
