//
//  ItunesSearchRequest.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

final class ItunesSearchRequest: IRequest {
    
    // Models
    private let term: String
    
    // MARK: - Initialize
    
    init(term: String) {
        self.term = term
    }
    
    // MARK: - IRequest
    
    var urlRequest: URLRequest? {
        guard let url = compositeUrl else { return nil }
        return URLRequest(url: url)
    }
    
    // MARK: - Private
    
    private var compositeUrl: URL? {
        let termParameter = term.addingPercentEncodingForFormData(plusForSpace: true) ?? term
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/search"
        components.query = "term=\(termParameter)"
        return components.url
    }
}
