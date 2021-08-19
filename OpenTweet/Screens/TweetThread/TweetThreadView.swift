//
//  TweetThreadView.swift
//  OpenTweet
//
//  Created by Mike Griffin on 8/14/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

class TweetThreadViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryBackground
        print("here should be a tweet")
        print(mainTweet)
        print(replyTweets)
        buildMainTweetView()
        buildReplyTweetsCollectionview()
    }
    
    init(mainTweet: Tweet, replyTweets: [Tweet], imageDict: [String: UIImage]) {
        self.mainTweet = mainTweet
        self.replyTweets = replyTweets
        self.imageDict = imageDict
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mainTweet: Tweet
    private let replyTweets: [Tweet]
    private let imageDict: [String: UIImage]
    
    private func buildMainTweetView() {
        // TODO split this out to seperate view file
        mainTweetView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainTweetView)
        let contentLabel = UILabel()
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.text = mainTweet.content
        contentLabel.numberOfLines = 5
        let authorLabel = UILabel()
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.text = mainTweet.author
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = mainTweet.date
        let avatarImage = UIImageView()
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.image = imageDict[mainTweet.id] ?? UIImage(named: "egg")
        avatarImage.layer.cornerRadius = 40
        avatarImage.clipsToBounds = true
        mainTweetView.addSubview(authorLabel)
        mainTweetView.addSubview(contentLabel)
        mainTweetView.addSubview(dateLabel)
        mainTweetView.addSubview(avatarImage)
        NSLayoutConstraint.activate([
            mainTweetView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            mainTweetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainTweetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainTweetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatarImage.centerYAnchor.constraint(equalTo: mainTweetView.centerYAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 80),
            avatarImage.heightAnchor.constraint(equalToConstant: 80),
            avatarImage.leadingAnchor.constraint(equalTo: mainTweetView.leadingAnchor),
            authorLabel.topAnchor.constraint(equalTo: mainTweetView.topAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: mainTweetView.trailingAnchor),
            authorLabel.heightAnchor.constraint(equalToConstant: 60),
            contentLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor),
            contentLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: authorLabel.trailingAnchor),
            contentLabel.heightAnchor.constraint(equalToConstant: 200),
            dateLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: mainTweetView.bottomAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func buildReplyTweetsCollectionview() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .secondaryBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TimelineCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: mainTweetView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private var mainTweetView = UIView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.estimatedItemSize = CGSize(width: Constants.cellWidth, height: Constants.smallCellHeight)
        //layout.itemSize = CGSize(width: Constants.cellWidth, height: Constants.smallCellHeight)
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    }()
}


extension TweetThreadViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return replyTweets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO remove force unwrap
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! TimelineCell
        let tweet = replyTweets[indexPath.item]
        cell.tweet = tweet
        cell.imageView.image = imageDict[tweet.id] ?? UIImage(named: "egg")
        return cell
    }
    
    
}

extension TweetThreadViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected tweet")
    }
}

// TODO fix this
private struct Constants {
    static let smallCellHeight: CGFloat = 100
    static let cellWidth: CGFloat = UIScreen.main.bounds.width
    static let cellIdentifier = "cellId"
}
