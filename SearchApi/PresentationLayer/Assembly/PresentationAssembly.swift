//
//  PresentationAssembly.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation
import UIKit

protocol IPresentationAssembly {
    
    var rootViewController: UINavigationController? { get }
}

class PresentationAssembly: IPresentationAssembly {
    
    private let servicesAssembly: IServicesAssembly
    
    init(servicesAssembly: IServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
    
    lazy var viewModelFactory: IViewModelFactory = ViewModelFactory()
    
    lazy var segmentFactory: ISegmentFactory = SegmentFactory(itunesSearchService: servicesAssembly.itunesSearchService,
                                                              lastFmSearchService: servicesAssembly.lastFmSearchService,
                                                              viewModelFactory: viewModelFactory)
    
    lazy var searchPresenter: ISearchPresenter = SearchPresenter(segmentFactory: segmentFactory)
    
    lazy var rootViewController: UINavigationController? = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let navigation = storyboard.instantiateInitialViewController() as? UINavigationController else {
            return nil
        }
        
        guard let searchViewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {
            return nil
        }
        
        searchViewController.presenter = searchPresenter
        searchPresenter.view = searchViewController
        
        navigation.viewControllers = [searchViewController]
        
        return navigation
    }()
}
