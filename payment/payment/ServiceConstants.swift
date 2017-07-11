//
//  ServiceConstants.swift
//  payment
//
//  Created by Fernando Romiti on 7/10/17.
//  Copyright © 2017 Fernando Romiti. All rights reserved.
//

import Foundation

struct ServiceConstants {
    struct BaseURL {
        static var Payment: String {
            return "https://api.mercadopago.com/v1/"
        }
    }
    
    struct PublicKey {
        static var Payment: String {
            return "444a9ef5-8a6b-429f-abdf-587639155d88"
        }
    }
}
