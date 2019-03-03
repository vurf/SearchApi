//
//  LastFmSearchRequest.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

final class LastFmSearchRequest: IRequest {
    
    // Models
    private let apiKey: String
    private let track: String
    private let page: Int
    
    // MARK: - Initialize
    
    init(track: String, page: Int) {
        self.track = track
        self.page = page
        self.apiKey = Keys.lastFM
    }
    
    // MARK: - IRequest
    
    var urlRequest: URLRequest? {
        guard let url = compositeUrl else { return nil }
        return URLRequest(url: url)
    }
    
    // MARK: - Private
    
    private var compositeUrl: URL? {
        let methodQuery = URLQueryItem(name: "method", value: "track.search")
        let trackQuery = URLQueryItem(name: "track", value: track)
        let apiQuery = URLQueryItem(name: "api_key", value: apiKey)
        let formatQuery = URLQueryItem(name: "format", value: "json")
        let pageQuery = URLQueryItem(name: "page", value: String(page))
        
        var components = URLComponents()
        components.scheme = "http"
        components.host = "ws.audioscrobbler.com"
        components.path = "/2.0/"
        components.queryItems = [methodQuery, trackQuery, apiQuery, formatQuery, pageQuery]
        return components.url
    }
}
