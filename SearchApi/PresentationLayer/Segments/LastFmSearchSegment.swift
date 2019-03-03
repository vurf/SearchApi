//
//  LastFmSearchSegment.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

public final class LastFmSearchSegment: BaseSearchSegment, ICanLoadMore {
    
    // Dependencies
    private let searchService: ILastFmSearchService
    private let viewModelFactory: IViewModelFactory
    
    // MARK: - Initialize
    
    public init(searchService: ILastFmSearchService, viewModelFactory: IViewModelFactory) {
        self.searchService = searchService
        self.viewModelFactory = viewModelFactory
    }
    
    // MARK: - BaseSearchSegment
    
    public override func search(_ text: String, with page: Int,
                       completion: @escaping (Result<[SearchViewModel]>) -> Void) -> URLSessionDataTask? {
        
        let task = searchService.search(text, with: page) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.totalCount = Int(model.results.opensearchTotalResults) ?? 0
                completion(.success(model.results.trackmatches.track.compactMap(self.viewModelFactory.map)))
            case .error(let error):
                completion(.error(error))
            }
        }
        
        return task
    }
    
    // MARK: - ICanLoadMore
    
    public func loadMore(with text: String?) {
        guard !isLoading else { return }
        
        if totalCount == 0 {
            showEmptySearch()
            return
        }
        
        if viewModels.count >= totalCount {
            return
        }
        
        currentPage += 1
        searchInternal(text, page: currentPage)
    }
}
