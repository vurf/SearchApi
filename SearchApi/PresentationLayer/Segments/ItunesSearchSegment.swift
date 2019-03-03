//
//  ItunesSearchSegment.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

public final class ItunesSearchSegment: BaseSearchSegment {
    
    // Dependencies
    private let searchService: IItunesSearchService
    private let viewModelFactory: IViewModelFactory
    
    // MARK: - Initialize
    
    public init(searchService: IItunesSearchService, viewModelFactory: IViewModelFactory) {
        self.searchService = searchService
        self.viewModelFactory = viewModelFactory
    }
    
    // MARK: - BaseSearchSegment
    
    public override func search(_ text: String, with page: Int,
                       completion: @escaping (Result<[SearchViewModel]>) -> Void) -> URLSessionDataTask? {
        
        let task = searchService.search(text) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.totalCount = model.resultCount
                completion(.success(model.results.compactMap(self.viewModelFactory.map)))
            case .error(let error):
                completion(.error(error))
            }
        }
        
        return task
    }
}
