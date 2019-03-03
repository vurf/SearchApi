//
//  RequestsFactory.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

struct RequestsFactory {

    struct ITunesRequests {
        
        static func search(by term: String) -> RequestConfig<ItunesSearchParser> {
            let request = ItunesSearchRequest(term: term)
            return RequestConfig<ItunesSearchParser>(request: request, parser: ItunesSearchParser())
        }
    }
    
    struct LastFMRequests {
        
        static func search(by track: String, page: Int = 0) -> RequestConfig<LastFmSearchParser> {
            let request = LastFmSearchRequest(track: track, page: page)
            return RequestConfig<LastFmSearchParser>(request: request, parser: LastFmSearchParser())
        }
    }
}
