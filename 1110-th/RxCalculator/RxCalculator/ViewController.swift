//
//  ViewController.swift
//  RxCalculator
//
//  Created by Nikolas Burk on 09/11/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

  @IBOutlet weak var operationSegmentedControl: UISegmentedControl!
  @IBOutlet weak var firstValueTextField: UITextField!
  @IBOutlet weak var secondValueTextField: UITextField!
  @IBOutlet weak var operationLabel: UILabel!
  @IBOutlet weak var resultLabel: UILabel!
  
    let disposeBag = DisposeBag()
    let calculator = Calculator()

  // MARK: View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  
    
    let operationObservable: Observable<Calculator.Operation> = operationSegmentedControl.rx.value.map {
        selectedIndex in
        let operation = Calculator.Operation(rawValue: selectedIndex)!
        return operation
    }
    let signObservable: Observable<String> = operationObservable.map {
        (operation: Calculator.Operation) in
        return self.calculator.sign(for: operation)
    }
    signObservable.bindTo(operationLabel.rx.text).addDisposableTo(disposeBag)
    
    let firstValueObservable: Observable<Int> = firstValueTextField.rx.text.map { string in
        return Int(string!)! }
    
    let secondValueObservable: Observable<Int> = secondValueTextField.rx.text.map { string in
        return Int(string!)! }
    
    let resultObservable: Observable<String> = Observable.combineLatest(firstValueObservable, secondValueObservable, operationObservable) {
        (firstValue, secondValue, operation) -> Int in
        switch operation {
        case .addition: return self.calculator.add(a: firstValue, b: secondValue)
        case .subtraction: return self.calculator.subtract(a: firstValue, b: secondValue)
            }
        }.map { resultInt in
            return String(resultInt)
    }
    resultObservable.bindTo(resultLabel.rx.text).addDisposableTo(disposeBag)
    
    
    
    
    
    
  }

}

