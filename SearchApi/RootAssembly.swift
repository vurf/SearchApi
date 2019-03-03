//
//  RootAssembly.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

class RootAssembly {
    
    lazy var presentationAssembly: IPresentationAssembly = PresentationAssembly(servicesAssembly: servicesAssembly)
    
    private lazy var servicesAssembly: IServicesAssembly = ServicesAssembly(coreAssembly: coreAssembly)
    
    private lazy var coreAssembly: ICoreAssembly = CoreAssembly()
}
