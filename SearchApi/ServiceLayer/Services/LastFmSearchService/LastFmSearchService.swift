//
//  LastFmSearchService.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

public protocol ILastFmSearchService {
    
    func search(_ text: String, with page: Int,
                completion: @escaping (Result<LastFmSearchModel>) -> Void) -> URLSessionDataTask?
}

public final class LastFmSearchService: ILastFmSearchService {
    
    // Dependencies
    private let requestSender: IRequestSender
    
    // Initialize
    public init(requestSender: IRequestSender) {
        self.requestSender = requestSender
    }
    
    // MARK: - ILastFmSearchService
    
    public func search(_ text: String, with page: Int,
                completion: @escaping (Result<LastFmSearchModel>) -> Void) -> URLSessionDataTask? {
        let request = RequestsFactory.LastFMRequests.search(by: text, page: page)
        return requestSender.send(requestConfig: request, completionHandler: completion)
    }
}
