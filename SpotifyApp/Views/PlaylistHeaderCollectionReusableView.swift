//
//  PlaylistHeaderCollectionReusableView.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 3.8.21..
//

import UIKit
import SDWebImage

protocol PlaylistHeaderCollectionReusableViewDelegate: AnyObject {
    func PlaylistHeaderCollectionReusableViewDidTapPlayAll(_ headr: PlaylistHeaderCollectionReusableView)
}

final class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "PlaylistHeaderCollectionReusableView"
    
    public weak var delegate: PlaylistHeaderCollectionReusableViewDelegate?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let ownerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let playlistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    private let playAllButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.clipsToBounds = true
        let image = UIImage(systemName: "play.fill",
                            withConfiguration: UIImage.SymbolConfiguration(
                                pointSize: 30, weight: .regular))
        button.setImage(image, for: .normal)
        button.backgroundColor = .systemGreen
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(playlistImageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(ownerLabel)
        addSubview(playAllButton)
        playAllButton.addTarget(self, action: #selector(didTapPlayAllButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize: CGFloat = height / 1.8
        playlistImageView.frame = CGRect(x: (width - imageSize) / 2,
                                         y: 20,
                                         width: imageSize,
                                         height: imageSize)
        
        let labelWidth = width - 20
        let labelHeight: CGFloat = 50
        nameLabel.frame = CGRect(x: 10,
                                 y: playlistImageView.bottom + 5,
                                 width: labelWidth,
                                 height: labelHeight - 20)
        
        descriptionLabel.frame = CGRect(x: 10,
                                        y: nameLabel.bottom,
                                        width: labelWidth,
                                        height: labelHeight)
        
        ownerLabel.frame = CGRect(x: 10,
                                  y: descriptionLabel.bottom,
                                  width: labelWidth,
                                  height: labelHeight - 20)
        
        playAllButton.frame = CGRect(x: width - 80,
                                     y: height - 80,
                                     width: 60,
                                     height: 60)
        playAllButton.layer.cornerRadius = 30
    }
    
    public func configure(with viewModel: PlaylistHeaderViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        ownerLabel.text = viewModel.owner
        playlistImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
    
    @objc private func didTapPlayAllButton() {
        delegate?.PlaylistHeaderCollectionReusableViewDidTapPlayAll(self)
    }
}
