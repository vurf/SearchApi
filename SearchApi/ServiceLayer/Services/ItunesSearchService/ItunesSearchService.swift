//
//  ItunesSearchService.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

public protocol IItunesSearchService {
    
    func search(_ text: String, completion: @escaping (Result<ItunesSearchModel>) -> Void) -> URLSessionDataTask?
}

public final class ItunesSearchService: IItunesSearchService {
    
    // Dependencies
    private let requestSender: IRequestSender
    
    // Initialize
    public init(requestSender: IRequestSender) {
        self.requestSender = requestSender
    }
    
    // MARK: - IItunesSearchService
    
    public func search(_ text: String, completion: @escaping (Result<ItunesSearchModel>) -> Void) -> URLSessionDataTask? {
        let request = RequestsFactory.ITunesRequests.search(by: text)
        return requestSender.send(requestConfig: request, completionHandler: completion)
    }
}
