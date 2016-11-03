
//
//  ViewController.swift
//  DataBindings-demo
//
//  Created by Nikolas Burk on 02/11/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var stateSegmentedControl: UISegmentedControl!
  @IBOutlet weak var greetingsLabel: UILabel!
  @IBOutlet weak var greetingsTextField: UITextField!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet var greetingButtons: [UIButton]!
    
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func stateChanged(_ sender: UISegmentedControl) {

  }
  
  @IBAction func greetingsButtonPressed(_ sender: UIButton) {

  }
  
}


