//
//  SearchViewController.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import UIKit

private extension CGFloat {
    static let estimatedRowHeight: CGFloat = 80
}

public enum ViewState {
    case empty(message: String)
    case loading
    case data
    case error(message: String)
}

public protocol ISearchView: AnyObject {
    
    func reloadData()
    
    func render(_ state: ViewState)
    
    func showAlert(_ message: String)
}

public final class SearchViewController: UIViewController, ISearchView {

    // MARK: - UI
    
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var searchBar: SearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var indicatorActivity: UIActivityIndicatorView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var repeatButton: UIButton!
    
    // MARK: - Dependencies
    
    public var presenter: ISearchPresenter?
    
    // MARK: - Initialize
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSegmentedControl()
        searchBar.searchBarDelegate = self
        presenter?.viewDidLoad()
    }
    
    // MARK: - ISearchView
    
    public func reloadData() {
        tableView.reloadData()
    }
    
    public func render(_ state: ViewState) {
        [tableView, contentView, indicatorActivity, errorLabel, repeatButton]
            .forEach { $0?.isHidden = true }
        
        switch state {
        case .empty(let message):
            contentView.isHidden = false
            errorLabel.isHidden = false
            errorLabel.text = message
        case .loading:
            contentView.isHidden = false
            indicatorActivity.isHidden = false
            indicatorActivity.startAnimating()
        case .error(let message):
            contentView.isHidden = false
            repeatButton.isHidden = false
            errorLabel.isHidden = false
            errorLabel.text = message
        case .data:
            tableView.isHidden = false
        }
    }
    
    public func showAlert(_ message: String) {
        let controller = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        controller.show(self, sender: nil)
    }
    
    // MARK: - Private
    
    private func setupTableView() {
        tableView.allowsSelection = false
        tableView.contentInset.top = searchBar.bounds.height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = .estimatedRowHeight
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: ITunesTableViewCell.className, bundle: nil), forCellReuseIdentifier: ITunesTableViewCell.className)
        tableView.register(UINib(nibName: LastFmTableViewCell.className, bundle: nil), forCellReuseIdentifier: LastFmTableViewCell.className)
    }
    
    private func setupSegmentedControl() {
        segmentControl.setTitle(SearchType.iTunes.rawValue, forSegmentAt: 0)
        segmentControl.setTitle(SearchType.lastFm.rawValue, forSegmentAt: 1)
        segmentControl.addTarget(self, action: #selector(didChangeSegmentElement), for: .valueChanged)
    }
    
    @objc private func didChangeSegmentElement() {
        switch segmentControl.selectedSegmentIndex {
        case 0: presenter?.didChangeSegment(.iTunes)
        case 1: presenter?.didChangeSegment(.lastFm)
        default: break
        }
    }
    
    @IBAction private func handleRepeatButtonClick() {
        presenter?.didRepeatSearchButton()
    }
    
    private var lastSelectedImageStartFrame: CGRect?
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter, presenter.viewModels.count > indexPath.row else { return UITableViewCell() }
        
        let viewModel = presenter.viewModels[indexPath.row]
        switch viewModel {
        case .iTunes(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: ITunesTableViewCell.className,
                                                     for: indexPath) as? ITunesTableViewCell
            cell?.delegate = self
            cell?.configure(with: model)
            return cell ?? UITableViewCell()
        case .lastFm(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: LastFmTableViewCell.className,
                                                     for: indexPath) as? LastFmTableViewCell
            cell?.delegate = self
            cell?.configure(with: model)
            return cell ?? UITableViewCell()
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.viewModels.count ?? 0
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let remainingDistance = tableView.contentSize.height - tableView.contentOffset.y
        if remainingDistance <= tableView.bounds.height * 2 && tableView.contentSize.height >= tableView.bounds.height * 2 {
            presenter?.viewWillDisplayTheEndOfContent()
        }
    }
}

extension SearchViewController: TapImageDelegate {
    
    public func didTapImageView(_ sender: UIImageView, url: String) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.endEditing(true)
        
        let fullSizeImageView = UIImageView()
        fullSizeImageView.isUserInteractionEnabled = true
        fullSizeImageView.contentMode = .scaleAspectFit
        fullSizeImageView.backgroundColor = .white
        fullSizeImageView.loadImageUsingCache(withUrl: url)
        fullSizeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapFullSizeImageView)))
        view.addSubview(fullSizeImageView)
        
        let startFrame = view.convert(sender.bounds, from: sender)
        let finalFrame = view.frame
        
        lastSelectedImageStartFrame = startFrame
        fullSizeImageView.frame = startFrame
        UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveEaseInOut, animations: {
            fullSizeImageView.frame = finalFrame
        }, completion: nil)
    }
    
    @objc private func tapFullSizeImageView(_ sender: UIGestureRecognizer) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        guard let fullSizeImageView = sender.view else { return }
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            fullSizeImageView.frame = self?.lastSelectedImageStartFrame ?? .zero
        }) { [weak self] (finished) in
            guard finished else { return }
            fullSizeImageView.removeFromSuperview()
            self?.lastSelectedImageStartFrame = nil
        }
    }
}

// MARK: - SearchBarDelegate

extension SearchViewController: SearchBarDelegate {
    
    var debounce: TimeInterval {
        return 0.4
    }
    
    func searchBar(_ searchBar: SearchBar, didChangeText text: String?) {
        presenter?.search(text: text)
    }
}
