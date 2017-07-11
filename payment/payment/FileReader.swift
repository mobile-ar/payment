//
//  FileReader.swift
//  payment
//
//  Created by Fernando Romiti on 7/10/17.
//  Copyright © 2017 Fernando Romiti. All rights reserved.
//

import Foundation

public final class FileReader {
    public static func readFileFrom(filename: String, inDirectory subpath: String = "", bundle:Bundle = Bundle.main ) -> Data {
        guard let path = bundle.path(forResource: filename, ofType: "json", inDirectory: subpath) else { return Data() }
        
        if let dataString = try? String(contentsOfFile: path), let data = dataString.data(using: String.Encoding.utf8){
            return data
        } else {
            return Data()
        }
    }
}
