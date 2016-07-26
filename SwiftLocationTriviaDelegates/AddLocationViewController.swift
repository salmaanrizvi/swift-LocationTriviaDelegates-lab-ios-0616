//
//  AddLocationViewController.swift
//  SwiftLocationTriviaDelegates
//
//  Created by Salmaan Rizvi on 7/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

protocol AddLocationViewControllerDelegate : class {
    
    func addLocationViewControllerDidCancel(viewController: AddLocationViewController)
    
    func addLocationViewController(viewController: AddLocationViewController, shouldAllowLocationNamed name: String) -> Bool
    
    func addLocationViewController(viewController: AddLocationViewController, didAddLocationNamed name: String)
}

class AddLocationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    weak var delegate: AddLocationViewControllerDelegate?
    
    @IBAction func saveTapped(sender: AnyObject) {
        
        if let delegate = self.delegate {
            delegate.addLocationViewController(self, didAddLocationNamed: self.locationTextField.text!)
        }
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        print("Cancel 1")
        
        if let delegate = self.delegate {
            print("Delegate is not nil")
            delegate.addLocationViewControllerDidCancel(self)
        }
        print("Cancel 2")
    }
    
    override func viewDidLoad() {
        self.locationTextField.delegate = self
        self.locationTextField.placeholder = "Enter location name"
        self.saveButton.enabled = false
        self.cancelButton.enabled = true
    }
    
    @IBAction func textFieldEditingChanged(sender: UITextField) {
    
        if let delegate = self.delegate {
            if delegate.addLocationViewController(self, shouldAllowLocationNamed: sender.text!) {
                self.saveButton.enabled = true
            }
            else { self.saveButton.enabled = false }
        }
    }
}
