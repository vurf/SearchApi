//
//  SearchBar.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation
import UIKit

protocol SearchBarDelegate: AnyObject {
    
    func searchBar(_ searchBar: SearchBar, didChangeText text: String?)
    
    var debounce: TimeInterval { get }
}

final class SearchBar: UISearchBar {
    
    // MARK: - Dependencies
    
    weak var searchBarDelegate: SearchBarDelegate?
    
    // MARK: - Models
    
    private var debounceTimer: Timer?
    
    // MARK: - Initialize
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        delegate = self
        placeholder = "Введите текст"
    }
    
    private func performSearch(debounce: TimeInterval) {
        debounceTimer?.invalidate()
        if debounce > 0 {
            debounceTimer = Timer.scheduledTimer(timeInterval: debounce,
                                                 target: self,
                                                 selector: #selector(callSearchDelegate),
                                                 userInfo: nil,
                                                 repeats: false)
        } else {
            callSearchDelegate()
        }
    }
    
    @objc private func callSearchDelegate() {
        searchBarDelegate?.searchBar(self, didChangeText: text)
    }
}

// MARK: - UISearchBarDelegate

extension SearchBar: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performSearch(debounce: searchBarDelegate?.debounce ?? 0)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resignFirstResponder()
    }
}
