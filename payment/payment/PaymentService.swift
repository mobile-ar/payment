//
//  PaymentService.swift
//  payment
//
//  Created by Fernando Romiti on 7/10/17.
//  Copyright © 2017 Fernando Romiti. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

struct PaymentMethod {
    var id: String
    var name: String
    
    init() {
        self.id = ""
        self.name = ""
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

enum PaymentService {
    case listPaymentMethods
}

extension PaymentService: BaseService {
    
    var baseURL: URL {
        let str = ServiceConstants.BaseURL.Payment
        return URL(string: str)!
    }
    var path: String {
        switch self {
        case .listPaymentMethods:
            return "payment_methods"
        }
    }
    var method: Moya.Method {
        switch self {
        case .listPaymentMethods:
            return .get
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .listPaymentMethods:
            return ["public_key": ServiceConstants.PublicKey.Payment]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .listPaymentMethods:
            return URLEncoding.default
        }
    }
    var sampleData: Data {
        switch self {
        case .listPaymentMethods:
            return FileReader.readFileFrom(filename: "payment_methods")
        }
    }
    var task: Task {
        switch self {
        case .listPaymentMethods:
            return .request
        }
    }
    var parseJSON: (_ json: JSON) -> [[String:Any]]? {
        switch self {
        case .listPaymentMethods:
            return { json in
                var result = [[String:Any]]()
                for (_,paymentMethodJSON) in json {
                    
                    var currentPaymentMethod = [String:Any]()
                    
                    if let id = paymentMethodJSON["id"].string,
                        let name = paymentMethodJSON["name"].string {
                        
                        currentPaymentMethod["id"] = id
                        currentPaymentMethod["name"] = name
                        
                        result.append(currentPaymentMethod)
                    }
                }
                
                if result.count > 0 {
                    return result
                } else {
                    return nil
                }
            }
            
        }
    }
}

