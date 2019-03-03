//
//  SearchPresenter.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

private extension String {
    static let startSearch = "Начните поиск"
}

public enum SearchViewModel {
    case iTunes(model: ITunesTableViewCell.Model)
    case lastFm(model: LastFmTableViewCell.Model)
}

public enum SearchType: String {
    case iTunes = "iTunes"
    case lastFm = "Last FM"
}

public protocol ISearchPresenter {
    
    var viewModels: [SearchViewModel] { get }
    
    var view: ISearchView? { get set }
    
    func viewDidLoad()
    
    func viewWillDisplayTheEndOfContent()
    
    func didChangeSegment(_ type: SearchType)
    
    func search(text: String?)
    
    func didRepeatSearchButton()
}

public final class SearchPresenter: ISearchPresenter {
    
    // Dependencies
    private let segmentFactory: ISegmentFactory
    public weak var view: ISearchView?
    
    // Models
    private var searchType: SearchType
    private var segment: BaseSearchSegment
    private var searchText: String?
    
    // Pagination
    public var viewModels: [SearchViewModel] {
        return segment.viewModels
    }
    
    // MARK: - Initialize
    
    public init(segmentFactory: ISegmentFactory) {
        self.segmentFactory = segmentFactory
        searchType = .iTunes
        segment = segmentFactory.getSegment(searchType)
        segment.delegate = self
    }
    
    // MARK: - ISearchPresenter
    
    public func viewDidLoad() {
        view?.render(.empty(message: .startSearch))
    }
    
    public func didChangeSegment(_ type: SearchType) {
        searchType = type
        segment = segmentFactory.getSegment(searchType)
        segment.delegate = self
        segment.search(with: searchText)
    }
    
    public func search(text: String?) {
        searchText = text
        segment.search(with: searchText)
    }
    
    public func didRepeatSearchButton() {
        segment.search(with: searchText)
    }
    
    public func viewWillDisplayTheEndOfContent() {
        (segment as? ICanLoadMore)?.loadMore(with: searchText)
    }
}

// MARK: - ISearchSegmentDelegate

extension SearchPresenter: ISearchSegmentDelegate {
    
    public func showAndReloadData() {
        view?.render(.data)
        view?.reloadData()
    }
    
    public func showError(_ message: String) {
        if segment.currentPage > 0 {
            view?.showAlert(message)
        } else {
            view?.render(.error(message: message))
        }
    }
    
    public func showLoader() {
        view?.render(.loading)
    }
    
    public func showEmptySearch(_ message: String?) {
        view?.render(.empty(message: message ?? .startSearch))
    }
}
