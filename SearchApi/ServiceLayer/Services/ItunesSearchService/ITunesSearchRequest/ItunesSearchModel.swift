//
//  ItunesSearchModel.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

public struct ItunesSearchModel: Decodable {
    let resultCount: Int
    let results: [ItunesSearchResult]
}

public struct ItunesSearchResult: Decodable {
    let wrapperType: String
    let kind: String?
    let artistId, collectionId: Int?
    let trackId: Int?
    let artistName: String
    let collectionName: String?
    let trackName: String?
    let collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewUrl: String?
    let collectionViewUrl: String?
    let trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl30: String?
    let artworkUrl60, artworkUrl100: String
    let collectionPrice, trackPrice: Double?
    let releaseDate: Date
    let discCount, discNumber: Int?
    let trackCount: Int?
    let trackNumber, trackTimeMillis: Int?
    let country: String
    let currency: String
    let primaryGenreName: String
    let contentAdvisoryRating: String?
    let isStreamable: Bool?
    let copyright, description, collectionArtistName: String?
    let collectionArtistId: Int?
    let collectionArtistViewUrl: String?
}
