//
//  GenreCollectionViewCell.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 5.8.21..
//

import UIKit
import SDWebImage

class GenreCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GenreCollectionViewCell"
    
    private let colors: [UIColor] = [
        .systemRed,
        .systemBlue,
        .systemPink,
        .systemTeal,
        .systemGreen,
        .systemOrange,
        .systemPurple,
        .systemIndigo,
        .systemYellow,
        .darkGray]
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: config)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        addSubview(imageView)
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 2,
                                 y: 2,
                                 width: contentView.width - 4,
                                 height: contentView.height - 4)
        imageView.layer.cornerRadius = 10
        
        label.frame = CGRect(x: 10,
                             y: contentView.bottom - 40,
                             width: width - 20,
                             height: 30)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    func configure(with category: Category) {
        label.text = category.name
        imageView.sd_setImage(with: URL(string: category.icons.first?.url ?? ""), completed: nil)
        backgroundColor = colors.randomElement()
    }
}
