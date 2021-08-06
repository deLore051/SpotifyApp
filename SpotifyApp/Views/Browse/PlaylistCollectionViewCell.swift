//
//  FeaturedPlaylistCollectionViewCell.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 1.8.21..
//

import UIKit

class PlaylistCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PlaylistCollectionViewCell"
    
    private let playlistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    private let playlistNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = nil
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize: CGFloat = 140
        playlistCoverImageView.frame = CGRect(x: 5,
                                              y: 5,
                                              width: contentView.width - 10,
                                              height: imageSize)
        
        playlistCoverImageView.layer.cornerRadius = imageSize / 10
        let labelWidth: CGFloat = contentView.width - 10
        let labelHeight: CGFloat = 20
        let labelXposition: CGFloat = 10
        
        playlistNameLabel.frame = CGRect(x: labelXposition,
                                         y: playlistCoverImageView.bottom + 5,
                                         width: labelWidth,
                                         height: labelHeight)
        
        creatorNameLabel.frame = CGRect(x: labelXposition,
                                        y: playlistNameLabel.bottom,
                                        width: labelWidth,
                                        height: labelHeight)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
        playlistCoverImageView.image = nil
    }
    
    func configure(with viewModel: PlaylistCellViewModel) {
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }

}
