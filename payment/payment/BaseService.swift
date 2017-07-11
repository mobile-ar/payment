//
//  BaseService.swift
//  payment
//
//  Created by Fernando Romiti on 7/10/17.
//  Copyright © 2017 Fernando Romiti. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

protocol BaseService: TargetType {
    associatedtype ParsedModel
    
    var parseJSON: (_ json: JSON) -> (ParsedModel?) { get }
}
