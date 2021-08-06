//
//  AlbumTrackCollectionViewCell.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 4.8.21..
//

import UIKit

class AlbumTrackCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AlbumTrackCollectionViewCell"
    
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
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelWidth: CGFloat = contentView.width - 30
        let labelHeight: CGFloat = 20
        
        trackNameLabel.frame = CGRect(x: 10,
                                      y: 5,
                                      width: labelWidth,
                                      height: labelHeight)
        
        artistNameLabel.frame = CGRect(x: 10,
                                       y: trackNameLabel.bottom,
                                       width: labelWidth,
                                       height: labelHeight)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
    }
    
    func configure(with viewModel: AlbumCollectionViewCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
    }

}
