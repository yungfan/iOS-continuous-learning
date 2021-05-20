//
//  BadgeView.swift
//  DiffableDataSourceDemo
//
//  Created by 杨帆 on 2020/6/6.
//  Copyright © 2020 杨帆. All rights reserved.
//

import UIKit

class BadgeView: UICollectionReusableView {
    static let reuseIdentifier = "badge"
    let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func configure() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .red
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        let inset = CGFloat(2)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        ])
    }
}
