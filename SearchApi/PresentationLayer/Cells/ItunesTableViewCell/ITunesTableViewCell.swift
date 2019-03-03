//
//  ITunesTableViewCell.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import UIKit

public final class ITunesTableViewCell: UITableViewCell {

    public struct Model {
        let imageUrl: String
        let title: String
        let subtitle: String
        let accessoryTitle: String
        let highImageUrl: String
        
        public init(imageUrl: String,
                    title: String,
                    subtitle: String,
                    accessoryTitle: String,
                    highImageUrl: String) {
            self.imageUrl = imageUrl
            self.title = title
            self.subtitle = subtitle
            self.accessoryTitle = accessoryTitle
            self.highImageUrl = highImageUrl
        }
    }
    
    // Dependencies
    weak var delegate: TapImageDelegate?
    
    // Models
//    private var tapGesture: UITapGestureRecognizer?
    private var viewModel: Model?
    
    // MARK: - UI
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var accessoryLabel: UILabel!
    
    // MARK: - Lifecycle
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        artworkImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImageView)))
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        artworkImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        accessoryLabel.text = nil
    }
    
    // MARK: - Configurable
    
    public func configure(with model: Model) {
        viewModel = model
        artworkImageView.loadImageUsingCache(withUrl: model.imageUrl)
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        accessoryLabel.text = model.accessoryTitle
    }
    
    // MARK: - Private
    
    @objc private func tapImageView() {
        guard let viewModel = viewModel else { return }
        delegate?.didTapImageView(artworkImageView, url: viewModel.highImageUrl)
    }
}
