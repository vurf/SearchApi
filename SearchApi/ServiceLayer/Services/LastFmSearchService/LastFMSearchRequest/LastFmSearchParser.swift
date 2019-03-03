//
//  LastFmSearchParser.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

class LastFmSearchParser: IParser {
    
    typealias Model = LastFmSearchModel
    
    func parse(data: Data) -> LastFmSearchModel? {
        do {
            return try JSONDecoder().decode(LastFmSearchModel.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}
