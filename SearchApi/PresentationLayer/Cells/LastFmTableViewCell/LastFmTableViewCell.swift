//
//  LastFmTableViewCell.swift
//  SearchApi
//
//  Created by i.varfolomeev on 26/02/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import UIKit

public class LastFmTableViewCell: UITableViewCell {

    public struct Model {
        let imageUrl: String
        let title: String
        let subtitle: String
        let counters: String
        let highImageUrl: String
        
        public init(imageUrl: String,
                    title: String,
                    subtitle: String,
                    counters: String,
                    highImageUrl: String) {
            self.imageUrl = imageUrl
            self.title = title
            self.subtitle = subtitle
            self.counters = counters
            self.highImageUrl = highImageUrl
        }
    }
    
    // Dependencies
    weak var delegate: TapImageDelegate?
    
    // Models
    private var tapGesture: UITapGestureRecognizer?
    private var viewModel: Model?
    
    // MARK: - UI
    
    @IBOutlet private weak var artImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var countersLabel: UILabel!
    
    // MARK: - Lifecycle
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        if let tapGesture = tapGesture {
            artImageView.removeGestureRecognizer(tapGesture)
        }
        artImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        countersLabel.text = nil
    }
    
    // MARK: - Configurable
    
    public func configure(with model: Model) {
        viewModel = model
        artImageView.loadImageUsingCache(withUrl: model.imageUrl)
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        countersLabel.text = model.counters
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapImageView))
        if let tapGesture = tapGesture {
            artImageView.addGestureRecognizer(tapGesture)
        }
    }
    
    // MARK: - Private
    
    @objc private func tapImageView() {
        guard let viewModel = viewModel else { return }
        delegate?.didTapImageView(artImageView, url: viewModel.highImageUrl)
    }
}
