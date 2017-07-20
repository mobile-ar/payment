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

struct CardIssuer {
    var id: String
    var name: String
    var secureThumbnail: String
    
    init() {
        self.id = ""
        self.name = ""
        self.secureThumbnail = ""
    }
    
    init(id: String, name: String, secureThumbnail: String) {
        self.id = id
        self.name = name
        self.secureThumbnail = secureThumbnail
    }
}

struct Installment {
    var recommendedMessage: String
    
    init() {
        self.recommendedMessage = ""
    }
    
    init(recommendedMessage: String) {
        self.recommendedMessage = recommendedMessage
    }
}


enum PaymentService {
    case listPaymentMethods
    case listCardIssuers(paymentMethodId: String)
    case listInstallments(amount: Float, paymentMethodId: String, issuerId: String)
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
        case .listCardIssuers:
            return "payment_methods/card_issuers"
        case .listInstallments:
            return "payment_methods/installments"
        }
    }
    var method: Moya.Method {
        switch self {
        case .listPaymentMethods:
            return .get
        case .listCardIssuers:
            return .get
        case .listInstallments:
            return .get
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .listPaymentMethods:
            return ["public_key": ServiceConstants.PublicKey.Payment]
        case .listCardIssuers(let paymentMethodId):
            return ["public_key": ServiceConstants.PublicKey.Payment,
                    "payment_method_id": paymentMethodId]
        case .listInstallments(let amount, let paymentMethodId, let issuerId):
            return ["public_key": ServiceConstants.PublicKey.Payment,
                    "amount": amount,
                    "payment_method_id": paymentMethodId,
                    "issuer.id": issuerId]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .listPaymentMethods:
            return URLEncoding.default
        case .listCardIssuers:
            return URLEncoding.default
        case .listInstallments:
            return URLEncoding.default
        }
    }
    var sampleData: Data {
        switch self {
        case .listPaymentMethods:
            return FileReader.readFileFrom(filename: "payment_methods")
        case .listCardIssuers:
            return FileReader.readFileFrom(filename: "card_issuers")
        case .listInstallments:
            return FileReader.readFileFrom(filename: "installments")
        }
    }
    var task: Task {
        switch self {
        case .listPaymentMethods:
            return .request
        case .listCardIssuers:
            return .request
        case .listInstallments:
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
        case .listCardIssuers:
            return { json in
                var result = [[String:Any]]()
                for (_,cardIssuersJSON) in json {
                    
                    var currentCardIssuer = [String:Any]()
                    
                    if let id = cardIssuersJSON["id"].string,
                        let name = cardIssuersJSON["name"].string,
                        let secureThumbnail = cardIssuersJSON["secure_thumbnail"].string {
                        
                        currentCardIssuer["id"] = id
                        currentCardIssuer["name"] = name
                        currentCardIssuer["secure_thumbnail"] = secureThumbnail
                        
                        result.append(currentCardIssuer)
                    }
                }
                
                if result.count > 0 {
                    return result
                } else {
                    return nil
                }
            }
        case .listInstallments:
            return { json in
                var result = [[String:Any]]()
                for (_,installmentsJSON) in json {
                    
                    var currentInstallment = [String:Any]()
                    
                    if let payerCosts = installmentsJSON["payer_costs"].array {
                        for cost in payerCosts {
                            if let recommendedMessage = cost["recommended_message"].string {
                                currentInstallment["recommended_message"] = recommendedMessage
                                result.append(currentInstallment)
                            }
                        }
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

