//
//  SegmentFactory.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

public protocol ISegmentFactory {
    
    func getSegment(_ searchType: SearchType) -> BaseSearchSegment
}

public class SegmentFactory: ISegmentFactory {
    
    // Dependencies
    private let itunesSearchService: IItunesSearchService
    private let lastFmSearchService: ILastFmSearchService
    private let viewModelFactory: IViewModelFactory
    
    // MARK: - Initialize
    
    public init(itunesSearchService: IItunesSearchService,
                lastFmSearchService: ILastFmSearchService,
                viewModelFactory: IViewModelFactory) {
        self.itunesSearchService = itunesSearchService
        self.lastFmSearchService = lastFmSearchService
        self.viewModelFactory = viewModelFactory
    }
    
    // MARK: - ISegmentFactory
    
    public func getSegment(_ searchType: SearchType) -> BaseSearchSegment {
        switch searchType {
        case .iTunes:
            return ItunesSearchSegment(searchService: itunesSearchService,
                                       viewModelFactory: viewModelFactory)
        case .lastFm:
            return LastFmSearchSegment(searchService: lastFmSearchService,
                                       viewModelFactory: viewModelFactory)
        }
    }
}
