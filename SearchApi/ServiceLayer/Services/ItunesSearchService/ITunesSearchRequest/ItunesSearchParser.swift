//
//  ItunesSearchParser.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

class ItunesSearchParser: IParser {
    
    typealias Model = ItunesSearchModel
    
    private let decoder = JSONDecoder()
    
    init() {
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func parse(data: Data) -> ItunesSearchModel? {
        do {
            return try decoder.decode(ItunesSearchModel.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}
