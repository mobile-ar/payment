//
//  InstallmentsCell.swift
//  payment
//
//  Created by Fernando Romiti on 7/19/17.
//  Copyright © 2017 Fernando Romiti. All rights reserved.
//

import Foundation
import UIKit

class InstallmentsCell: UITableViewCell {
    
    @IBOutlet weak var recommendedMessageLabel: UILabel!
    
    var item = Installment() {
        didSet {
            self.recommendedMessageLabel.text = item.recommendedMessage
        }
    }
    
}
