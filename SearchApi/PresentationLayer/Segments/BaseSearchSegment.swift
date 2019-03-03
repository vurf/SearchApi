//
//  BaseSearchSegment.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

private extension String {
    static let hasNotResults = "Поиск не дал результатов"
}

public protocol ISearchSegmentDelegate: AnyObject {
    
    func showAndReloadData()
    
    func showLoader()
    
    func showError(_ message: String)
    
    func showEmptySearch(_ message: String?)
}

public class BaseSearchSegment {
    
    // Models
    public var viewModels = [SearchViewModel]()
    public var currentPage = 0
    public var isLoading = false
    public var totalCount = 0
    public weak var delegate: ISearchSegmentDelegate?
    private var dataTask: URLSessionDataTask?
    
    // Initialize
    public init() {
        guard type(of: self) != BaseSearchSegment.self else {
            fatalError("It's abstract class, do not try to create instance of this class")
        }
    }
    
    // Search
    
    public func search(with text: String?) {
        viewModels = []
        delegate?.showAndReloadData()
        delegate?.showLoader()
        
        currentPage = 0
        searchInternal(text, page: currentPage)
    }
    
    public func search(_ text: String, with page: Int, completion: @escaping (Result<[SearchViewModel]>) -> Void) -> URLSessionDataTask? {
        fatalError("Need to implement \(#function) method") 
    }
    
    internal func searchInternal(_ text: String?, page: Int) {
        guard let text = text, !text.isEmpty else {
            delegate?.showEmptySearch(nil)
            return
        }
        
        dataTask?.cancel()
        isLoading = true
        
        dataTask = search(text, with: page, completion: { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            DispatchQueue.main.async {
                switch result {
                case .success(let models):
                    self.handleSuccessResult(models, for: page)
                case .error(let error):
                    self.delegate?.showError(error)
                }
            }
        })
    }
    
    internal func showEmptySearch() {
        delegate?.showEmptySearch(.hasNotResults)
    }
    
    private func handleSuccessResult(_ models: [SearchViewModel], for page: Int) {
        guard totalCount != 0 else {
            showEmptySearch()
            return
        }
        
        if page == 0 {
            viewModels = models
        } else {
            viewModels += models
        }
        
        delegate?.showAndReloadData()
    }
}
