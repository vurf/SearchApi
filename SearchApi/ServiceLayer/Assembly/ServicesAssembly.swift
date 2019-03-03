//
//  ServicesAssembly.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

protocol IServicesAssembly {
    
    var itunesSearchService: IItunesSearchService { get }
    
    var lastFmSearchService: ILastFmSearchService { get }
}

class ServicesAssembly: IServicesAssembly {
    
    private let coreAssembly: ICoreAssembly
    
    init(coreAssembly: ICoreAssembly) {
        self.coreAssembly = coreAssembly
    }
    
    lazy var itunesSearchService: IItunesSearchService = ItunesSearchService(requestSender: coreAssembly.requestSender)
    
    lazy var lastFmSearchService: ILastFmSearchService = LastFmSearchService(requestSender: coreAssembly.requestSender)
}
