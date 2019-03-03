//
//  ItunesSearchServiceMock.swift
//  SearchApiTests
//
//  Created by i.varfolomeev on 03/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation
import SearchApi

final class ItunesSearchServiceMock: IItunesSearchService {
    
    var searchPerformResult: Result<ItunesSearchModel>?
    var searchPerformDataTask: URLSessionDataTask?
    var searchPerformIsCalled: Bool = false
    
    func search(_ text: String, completion: @escaping (Result<ItunesSearchModel>) -> Void) -> URLSessionDataTask? {
        searchPerformIsCalled = true
        
        if let result = searchPerformResult {
            completion(result)
        } else {
            completion(.error("Error"))
        }
        
        return searchPerformDataTask
    }
}
