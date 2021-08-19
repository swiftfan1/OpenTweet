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
        label.numberOfLines = 10
        label.sizeToFit()
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.secondaryText
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.secondaryText
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "egg")!
        return imageView
    }()
    
    let cellContent: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var tweet: Tweet? {
        didSet {
            if let tweet = tweet {
                contentLabel.text = tweet.content
                authorLabel.text = tweet.author
                dateLabel.text = tweet.date.timelineDisplayDate()
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
        addSubview(cellContent)
        cellContent.addSubview(contentLabel)
        cellContent.addSubview(authorLabel)
        cellContent.addSubview(dateLabel)
        cellContent.addSubview(imageView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            cellContent.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cellContent.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            cellContent.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            cellContent.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: cellContent.leadingAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.centerYAnchor.constraint(equalTo: cellContent.centerYAnchor),
            authorLabel.topAnchor.constraint(equalTo: cellContent.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            authorLabel.heightAnchor.constraint(equalToConstant: 30),
            dateLabel.topAnchor.constraint(equalTo: authorLabel.topAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: authorLabel.bottomAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: cellContent.trailingAnchor, constant: -16),
            contentLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor),
            contentLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: cellContent.trailingAnchor, constant: -16),
            contentLabel.bottomAnchor.constraint(equalTo: cellContent.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
