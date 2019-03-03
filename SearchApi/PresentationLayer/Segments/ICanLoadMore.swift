//
//  ICanLoadMore.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

public protocol ICanLoadMore {
    
    func loadMore(with text: String?)
}
