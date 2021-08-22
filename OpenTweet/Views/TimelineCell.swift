//
//  TimelineCell.swift
//  OpenTweet
//
//  Created by Mike Griffin on 8/12/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

class TimelineCell: UITableViewCell {
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
    
    let avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "egg")!
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
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
                contentLabel.attributedText = tweet.content.attributedDisplay()
                authorLabel.text = tweet.author
                dateLabel.text = tweet.date.displayDate(format: "M/d/yy")
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .primaryBackground
        addSubviews()
        configureConstraints()
    }
    private func addSubviews() {
        addSubview(cellContent)
        cellContent.addSubview(contentLabel)
        cellContent.addSubview(authorLabel)
        cellContent.addSubview(dateLabel)
        cellContent.addSubview(avatarView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            cellContent.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cellContent.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            cellContent.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            cellContent.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            avatarView.leadingAnchor.constraint(equalTo: cellContent.leadingAnchor, constant: 16),
            avatarView.heightAnchor.constraint(equalToConstant: 60),
            avatarView.widthAnchor.constraint(equalToConstant: 60),
            avatarView.centerYAnchor.constraint(equalTo: cellContent.centerYAnchor),
            authorLabel.topAnchor.constraint(equalTo: cellContent.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 16),
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
