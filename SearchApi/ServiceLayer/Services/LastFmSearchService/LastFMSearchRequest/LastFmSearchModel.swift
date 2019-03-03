//
//  LastFmSearchModel.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

public struct LastFmSearchModel: Decodable {
    let results: LastFmResults
}

public struct LastFmResults: Decodable {
    let opensearchQuery: LastFmOpensearchQuery
    let opensearchTotalResults, opensearchStartIndex, opensearchItemsPerPage: String
    let trackmatches: LastFmTrackmatches
    
    enum CodingKeys: String, CodingKey {
        case opensearchQuery = "opensearch:Query"
        case opensearchTotalResults = "opensearch:totalResults"
        case opensearchStartIndex = "opensearch:startIndex"
        case opensearchItemsPerPage = "opensearch:itemsPerPage"
        case trackmatches
    }
}

public struct LastFmOpensearchQuery: Decodable {
    let text, role, startPage: String
    
    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case role
        case startPage
    }
}

public struct LastFmTrackmatches: Decodable {
    let track: [LastFmTrack]
}

public struct LastFmTrack: Decodable {
    let name, artist: String
    let url: String
    let streamable: String
    let listeners: String
    let image: [LastFmImage]
    let mbid: String
}

public struct LastFmImage: Decodable {
    let text: String
    let size: LastFmSize
    
    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size
    }
}

public enum LastFmSize: String, Decodable {
    case extralarge
    case large
    case medium
    case small
}
