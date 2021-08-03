//
//  NewReleaseCollectionViewCell.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 1.8.21..
//

import UIKit
import SDWebImage

class NewReleaseCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NewReleaseCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "photo")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let numberOfTracksLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(numberOfTracksLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize: CGFloat = contentView.height - 10
        albumCoverImageView.frame = CGRect(x: 5,
                                           y: 5,
                                           width: imageSize,
                                           height: imageSize)
        
        albumCoverImageView.layer.cornerRadius = imageSize / 10
        let labelWidth: CGFloat = contentView.width - imageSize - 30
        let labelHeight: CGFloat = (contentView.height - 30) / 3
        let labelXposition = imageSize + 15
        
        albumNameLabel.frame = CGRect(x: labelXposition,
                                      y: 5,
                                      width: labelWidth,
                                      height: labelHeight)
        
        artistNameLabel.frame = CGRect(x: labelXposition,
                                       y: albumNameLabel.bottom,
                                       width: labelWidth,
                                       height: labelHeight - 10)
        
        numberOfTracksLabel.frame = CGRect(x: labelXposition,
                                           y: contentView.bottom - labelHeight,
                                           width: labelWidth,
                                           height: labelHeight)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text = nil
        artistNameLabel.text = nil
        numberOfTracksLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel: NewReleasesCellViewModel) {
        albumNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        numberOfTracksLabel.text = "Tracks: \(viewModel.numberOfTracks)"
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
