
//
//  ViewController.swift
//  DataBindings-demo
//
//  Created by Nikolas Burk on 02/11/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate
{
    
    @IBOutlet weak var stateSegmentedControl: UISegmentedControl!
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var greetingsTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet var greetingButtons: [UIButton]!
    
    var greeting: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        greetingsLabel.text = "\(nameTextField.text!)"
        greetingsTextField.isEnabled = false
        greetingsTextField.addTarget(self, action: #selector(ViewController.updateGreetingsLabel), for: .allEvents)
        nameTextField.addTarget(self, action: #selector(ViewController.updateGreetingsLabel), for: .allEvents)
    }
    
    @IBAction func stateChanged(_ sender: UISegmentedControl) {
        if stateSegmentedControl.selectedSegmentIndex == 0 {
            
            greetingsTextField.isEnabled = false
            
            for button in greetingButtons {
                button.isEnabled = true
            }
        } else {
            
            for button in greetingButtons {
                button.isEnabled = false
            }
            
            greetingsTextField.isEnabled =  true
        }
        
        
    }
    
    @IBAction func greetingsButtonPressed(_ sender: UIButton) {
        greeting = sender.titleLabel!.text!
        greetingsLabel.text = "\(sender.titleLabel!.text!), \(nameTextField.text!)"
    }
    
    func updateGreetingsLabel() {
        if greetingsTextField.isEnabled {
            
            if greetingsTextField.text == "" {
                greetingsLabel.text = "\(greeting!), \(nameTextField.text!) "
            } else {
                greeting = greetingsTextField.text!
                greetingsLabel.text = "\(greetingsTextField.text!), \(nameTextField.text!) "
            }
            
        } else {
            greetingsLabel.text = "\(greeting!), \(nameTextField.text!)"
        }
    }
    
    
    
}





