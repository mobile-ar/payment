//
//  AmountViewController.swift
//  payment
//
//  Created by Fernando Romiti on 7/8/17.
//  Copyright © 2017 Fernando Romiti. All rights reserved.
//

import UIKit

class AmountViewController: UIViewController, UITextFieldDelegate, InstallmentsDelegate {
    
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var creditCardButton: UIButton!
    
    @IBAction func creditCardButtonTapped(_ sender: UIButton) {
        guard let amountString = self.amountField.text else { return }
        guard let amount = Float(amountString) else { return }
        ControllerNavigator.showPaymentMethod(for: amount, delegate: self)
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

    // MARK: InstallmentsDelegate
    
    func selected(amount: Float, paymentMethod: String, cardIssuer: String, installment: String) {
        let title = "Your selection"
        let message = "Amount: \(amount)\nPayment Method: \(paymentMethod)\nCard Issuer: \(cardIssuer)\nInstallments: \(installment)"
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let dismissAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel)
        alertController.addAction(dismissAction)
        
        self.present(alertController, animated: true, completion: { self.amountField.text = "" })
    }
}

