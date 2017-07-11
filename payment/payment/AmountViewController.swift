//
//  AmountViewController.swift
//  payment
//
//  Created by Fernando Romiti on 7/8/17.
//  Copyright © 2017 Fernando Romiti. All rights reserved.
//

import UIKit

class AmountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var creditCardButton: UIButton!
    
    @IBAction func creditCardButtonTapped(_ sender: UIButton) {
        // show payment method
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.amountField.delegate = self
    }
    
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }

}

