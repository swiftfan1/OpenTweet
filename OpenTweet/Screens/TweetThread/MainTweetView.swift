//
//  MainTweetView.swift
//  OpenTweet
//
//  Created by Mike Griffin on 8/20/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

class MainTweetView: UIView {
    init(tweet: Tweet) {
        super.init(frame: .zero)
        let contentLabel = UILabel()
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.text = tweet.content
        contentLabel.numberOfLines = 5
        let authorLabel = UILabel()
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.text = tweet.author
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = tweet.date
        let avatarImage = UIImageView()
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.image = ImageManager.shared.imageCache.object(forKey: NSString(string: tweet.avatar ?? "")) ?? UIImage(named: "egg")
        avatarImage.layer.cornerRadius = 40
        avatarImage.clipsToBounds = true
        addSubview(avatarImage)
        addSubview(authorLabel)
        addSubview(contentLabel)
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            avatarImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 80),
            avatarImage.heightAnchor.constraint(equalToConstant: 80),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: authorLabel.trailingAnchor),
            contentLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            authorLabel.heightAnchor.constraint(equalToConstant: 60),
            authorLabel.bottomAnchor.constraint(equalTo: contentLabel.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
