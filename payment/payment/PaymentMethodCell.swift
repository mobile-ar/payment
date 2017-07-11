//
//  PaymentMethodCell.swift
//  payment
//
//  Created by Fernando Romiti on 7/11/17.
//  Copyright © 2017 Fernando Romiti. All rights reserved.
//

import Foundation
import UIKit

class PaymentMethodCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var item = PaymentMethod() {
        didSet {
            self.nameLabel.text = item.name
        }
    }
    
}
