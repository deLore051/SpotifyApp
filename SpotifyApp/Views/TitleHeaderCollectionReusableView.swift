//
//  TitleHeaderCollectionReusableView.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 4.8.21..
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "TitleHeaderCollectionReusableView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = CGRect(x: 30, y: 15, width: width - 40, height: height - 30)
    }
    
    public func configure(with title: String) {
        self.titleLabel.text = title
    }
}
