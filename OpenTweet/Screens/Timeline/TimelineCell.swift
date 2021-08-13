//
//  TimelineCell.swift
//  OpenTweet
//
//  Created by Mike Griffin on 8/12/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

class TimelineCell: UICollectionViewCell {
    let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 5
        return label
    }()
    
    var tweet: Tweet? {
        didSet {
            if let tweet = tweet {
                contentLabel.text = tweet.content
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        addSubviews()
        configureConstraints()
    }
    
    private func addSubviews() {
        addSubview(contentLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            contentLabel.centerXAnchor.constraint(equalTo:safeAreaLayoutGuide.centerXAnchor),
            contentLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            contentLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
