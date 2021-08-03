//
//  RecommendedTrackCollectionViewCell.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 1.8.21..
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RecommendedTrackCollectionViewCell"
    
    private let trackCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(trackCoverImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize: CGFloat = contentView.height - 10
        trackCoverImageView.frame = CGRect(x: 5,
                                           y: 5,
                                           width: imageSize,
                                           height: imageSize)
        
        trackCoverImageView.layer.cornerRadius = imageSize / 10
        
        let labelWidth: CGFloat = contentView.width - imageSize - 25
        let labelHeight: CGFloat = 20
        let labelXposition: CGFloat = imageSize + 15
        
        trackNameLabel.frame = CGRect(x: labelXposition,
                                      y: 5,
                                      width: labelWidth,
                                      height: labelHeight)
        
        artistNameLabel.frame = CGRect(x: labelXposition,
                                       y: trackNameLabel.bottom + 5,
                                       width: labelWidth,
                                       height: labelHeight)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackCoverImageView.image = nil
        trackNameLabel.text = nil
        artistNameLabel.text = nil
    }
    
    func configure(with viewModel: RecommendedTrackCellViewModel) {
        trackCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
    }

}
