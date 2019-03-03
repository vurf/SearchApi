//
//  ViewModelFactoryMock.swift
//  SearchApiTests
//
//  Created by i.varfolomeev on 03/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation
import SearchApi

class ViewModelFactoryMock: IViewModelFactory {
    var performMapItunesCalled: Bool = false
    var performMapLastFmCalled: Bool = false
    var itunesMapResult: SearchViewModel?
    var lastFmMapResult: SearchViewModel?
    
    func map(_ model: ItunesSearchResult) -> SearchViewModel {
        performMapItunesCalled = true
        if let itunesMapResult = itunesMapResult {
            return itunesMapResult
        }
        
        let model = ITunesTableViewCell.Model(imageUrl: "imageUrl",
                                              title: "title",
                                              subtitle: "subtitle",
                                              accessoryTitle: "accessoryTitle",
                                              highImageUrl: "highImageUrl")
        
        return .iTunes(model: model)
    }
    
    func map(_ model: LastFmTrack) -> SearchViewModel {
        performMapLastFmCalled = true
        if let lastFmMapResult = lastFmMapResult {
            return lastFmMapResult
        }
        
        let model = LastFmTableViewCell.Model(imageUrl: "imageUrl",
                                              title: "title",
                                              subtitle: "subtitle",
                                              counters: "counters",
                                              highImageUrl: "highImageUrl")
        return .lastFm(model: model)
    }
}
