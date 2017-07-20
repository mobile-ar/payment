//
//  Extensions.swift
//  payment
//
//  Created by Fernando Romiti on 7/18/17.
//  Copyright © 2017 Fernando Romiti. All rights reserved.
//

import UIKit

extension UIApplication {
    
    static var appDelegate:AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    static var window:UIWindow {
        return self.appDelegate.window!
    }
    
}
