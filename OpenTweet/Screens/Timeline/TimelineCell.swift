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
        label.sizeToFit()
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tweet: Tweet? {
        didSet {
            if let tweet = tweet {
                contentLabel.text = tweet.content
                authorLabel.text = tweet.author
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .primaryBackground
        addSubviews()
        configureConstraints()
    }
    
    private func addSubviews() {
        addSubview(contentLabel)
        addSubview(authorLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            authorLabel.heightAnchor.constraint(equalToConstant: 30),
            contentLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor),
            //contentLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            contentLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            contentLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: -32),
            contentLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
