
//
//  ViewController.swift
//  DataBindings-demo
//
//  Created by Nikolas Burk on 02/11/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  enum State: Int {
    case useButtons
    case useTextField
  }
  
  enum TextFieldTag: Int {
    case greetingTextField
    case nameTextField
  }
  
  @IBOutlet weak var stateSegmentedControl: UISegmentedControl!
  @IBOutlet weak var greetingsLabel: UILabel!
  @IBOutlet weak var greetingsTextField: UITextField!
  @IBOutlet weak var nameTextField: UITextField!
  
  @IBOutlet var greetingButtons: [UIButton]!
  
  var lastSelectedButtonTitle = "Hello" // default
  
  var state: State = .useButtons {
    didSet {
      switch state {
      case .useButtons:
        greetingsLabel.text = "\(lastSelectedButtonTitle), \(nameTextField.text!)"
        greetingsTextField.isEnabled = false
        greetingButtons.forEach { button in
          button.isEnabled = true
        }
      case .useTextField:
        greetingsLabel.text = "\(greetingsTextField.text!), \(nameTextField.text!)"
        greetingsTextField.isEnabled = true
        greetingButtons.forEach { button in
          button.isEnabled = false
        }
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    state = .useButtons
  }
  
  @IBAction func stateChanged(_ sender: UISegmentedControl) {
    guard let state = State(rawValue: sender.selectedSegmentIndex) else {
      return
    }
    self.state = state
  }
  
  @IBAction func greetingsButtonPressed(_ sender: UIButton) {
    guard let greetings = sender.titleLabel?.text else {
      return
    }
    lastSelectedButtonTitle = greetings
    greetingsLabel.text = "\(lastSelectedButtonTitle), \(nameTextField.text!)"
  }
  
}


extension ViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let fullGreeting: String
    if state == .useButtons {
      let greeting = lastSelectedButtonTitle
      fullGreeting = "\(greeting), \(nameTextField.text! + string)"
    }
    else {
      let greetingText: String
      let name: String
      if textField.tag == TextFieldTag.greetingTextField.rawValue {
        greetingText = greetingsTextField.text! + string
        name = nameTextField.text!
      }
      else {
        greetingText = greetingsTextField.text!
        name = nameTextField.text! + string
      }
      fullGreeting = "\(greetingText), \(name)"
    }
    
    greetingsLabel.text = fullGreeting
    
    return true
  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    if textField.tag == TextFieldTag.greetingTextField.rawValue {
      greetingsLabel.text = ", \(nameTextField.text!)"
    }
    else if textField.tag == TextFieldTag.nameTextField.rawValue {
      switch state {
      case .useButtons:
        greetingsLabel.text = "\(lastSelectedButtonTitle), "
      case .useTextField:
        greetingsLabel.text = "\(greetingsTextField.text!), "
      }
    }
    return true
  }
  
}

