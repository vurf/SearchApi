//
//  CoreAssembly.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

protocol ICoreAssembly {
    
    var requestSender: IRequestSender { get }
}

class CoreAssembly: ICoreAssembly {
    
    lazy var requestSender: IRequestSender = RequestSender()
}
