//
//  String+Encoding.swift
//  SearchApi
//
//  Created by i.varfolomeev on 02/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

extension String {
    
    public func addingPercentEncodingForRFC3986() -> String? {
        let unreserved = "-._~/?"
        var allowed = CharacterSet.alphanumerics
        allowed.insert(charactersIn: unreserved)
        
        return addingPercentEncoding(withAllowedCharacters: allowed)
    }
    
    public func addingPercentEncodingForFormData(plusForSpace: Bool = false) -> String? {
        let unreserved = "*-._"
        var allowed = CharacterSet.alphanumerics
        allowed.insert(charactersIn: unreserved)
        
        if plusForSpace {
            allowed.insert(charactersIn: " ")
        }
        
        var encoded = addingPercentEncoding(withAllowedCharacters: allowed)
        if plusForSpace {
            encoded = encoded?.replacingOccurrences(of: " ", with: "+")
        }
        
        return encoded
    }

}

