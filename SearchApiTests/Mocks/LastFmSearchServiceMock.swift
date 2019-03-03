//
//  LastFmSearchServiceMock.swift
//  SearchApiTests
//
//  Created by i.varfolomeev on 03/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation
import SearchApi

final class LastFmSearchServiceMock: ILastFmSearchService {
    
    var searchPerformResult: Result<LastFmSearchModel>?
    var searchPerformDataTask: URLSessionDataTask?
    var searchPerformIsCalled: Bool = false
    
    func search(_ text: String, with page: Int, completion: @escaping (Result<LastFmSearchModel>) -> Void) -> URLSessionDataTask? {
        searchPerformIsCalled = true
        
        if let result = searchPerformResult {
            completion(result)
        } else {
            completion(.error("Error"))
        }
        
        return searchPerformDataTask
    }
}
