//
//  ViewModelFactory.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

public protocol IViewModelFactory {
    
    func map(_ model: ItunesSearchResult) -> SearchViewModel
    
    func map(_ model: LastFmTrack) -> SearchViewModel
}

public final class ViewModelFactory: IViewModelFactory {
    
    public func map(_ model: ItunesSearchResult) -> SearchViewModel {
        
        let title = model.trackName ?? ""
        let artworkUrl = model.artworkUrl60
        var subtitle = model.artistName
        if let collectionName = model.collectionName {
            subtitle += " - " + collectionName
        }
        
        let accessoryTitle = model.country
        let highImageUrl = model.artworkUrl100
        
        let model = ITunesTableViewCell.Model(imageUrl: artworkUrl,
                                              title: title,
                                              subtitle: subtitle,
                                              accessoryTitle: accessoryTitle,
                                              highImageUrl: highImageUrl)
        
        return .iTunes(model: model)
    }
    
    public func map(_ model: LastFmTrack) -> SearchViewModel {
        
        let title = model.name
        let subtitle = model.artist
        let image = model.image.first(where: { $0.size == LastFmSize.small })?.text ?? ""
        let counters = model.listeners
        let highImage = model.image.first(where: { $0.size == LastFmSize.extralarge })?.text ?? image
        
        let model = LastFmTableViewCell.Model(imageUrl: image,
                                              title: title,
                                              subtitle: subtitle,
                                              counters: counters,
                                              highImageUrl: highImage)
        
        return .lastFm(model: model)
    }
}
