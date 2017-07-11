//
//  Network.swift
//  payment
//
//  Created by Fernando Romiti on 7/10/17.
//  Copyright © 2017 Fernando Romiti. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

struct Network<T: BaseService> {
    typealias EndpointClosure = (T) -> Endpoint<T>
    
    static func request(
        service: T,
        provider: MoyaProvider<T>? = nil,
        success successCallback: @escaping (T.ParsedModel?) -> (),
        error errorCallback: @escaping (MoyaError) -> (),
        failure failureCallback: @escaping (MoyaError) -> ()
        ) {

        let endpointClosure = { (target: T) -> Endpoint<T> in
            return MoyaProvider.defaultEndpointMapping(for: service)
        }
    
        let requestProvider = provider ?? MoyaProvider<T>(endpointClosure: endpointClosure,
                                                          manager: DefaultAlamofireManager.sharedManager)
    
        requestProvider.request(service, queue: DispatchQueue.global()){ result in
            switch result {
            case let .success(response):
                do {
                    // see if the response has 200-299 status code
                    let _ = try response.filterSuccessfulStatusCodes()
                    // use SwiftyJSON to get JSON from response
                    let json = JSON(data: response.data)
                    // TODO: Think about Error Handling here
                    let parsedResult = service.parseJSON(json)
                    successCallback(parsedResult)
                } catch let error as MoyaError {
                    errorCallback(error)
                } catch {
                    print("Unknown error: \(error)")
                }
            case let .failure(error):
                failureCallback(error)
                
            }
        }
    }
}
