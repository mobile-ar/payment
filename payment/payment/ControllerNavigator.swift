//
//  ControllerNavigator.swift
//  payment
//
//  Created by Fernando Romiti on 7/18/17.
//  Copyright © 2017 Fernando Romiti. All rights reserved.
//

import Foundation
import UIKit

class ControllerNavigator {
    
    class func showCardIssuers(for method: PaymentMethod, amount: Float, delegate: InstallmentsDelegate?) {
        let controller = ControllerSource.cardIssuersController(for: method, amount: amount, delegate: delegate)
        if let nav = UIApplication.window.rootViewController as? UINavigationController {
            nav.pushViewController(controller, animated: true)
        }
    }
    
    class func showInstallments(for method: PaymentMethod, amount: Float, issuer: CardIssuer, delegate: InstallmentsDelegate?) {
        let controller = ControllerSource.installmentsController(for: method, amount: amount, issuer: issuer, delegate: delegate)
        if let nav = UIApplication.window.rootViewController as? UINavigationController {
            nav.pushViewController(controller, animated: true)
        }
    }
    
    class func showPaymentMethod(for amount: Float, delegate: InstallmentsDelegate?) {
        let controller = ControllerSource.paymentMethodController(for: amount, delegate: delegate)
        if let nav = UIApplication.window.rootViewController as? UINavigationController {
            nav.pushViewController(controller, animated: true)
        }
    }
    
}
