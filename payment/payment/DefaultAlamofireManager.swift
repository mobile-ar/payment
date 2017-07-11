//
//  DefaultAlamofireManager.swift
//  payment
//
//  Created by Fernando Romiti on 7/10/17.
//  Copyright © 2017 Fernando Romiti. All rights reserved.
//

import Foundation
import Alamofire

class DefaultAlamofireManager: Alamofire.SessionManager {
    
    static let timeOutValue: Double = 60
    
    static let sharedManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = timeOutValue
        configuration.timeoutIntervalForResource = timeOutValue
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireManager(configuration: configuration)
    }()
}
