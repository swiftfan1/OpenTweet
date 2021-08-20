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
        buildReplyTweetsTableView()
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
        NSLayoutConstraint.activate([
            mainTweetView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4),
            mainTweetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainTweetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainTweetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

        ])
    }
    
    private func buildReplyTweetsTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .primaryBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TimelineCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: mainTweetView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private lazy var mainTweetView: MainTweetView = {
        return MainTweetView(tweet: mainTweet)
    }()
    
    private lazy var tableView: UITableView = {
        return UITableView()
    }()
}


extension TweetThreadViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Replies"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return replyTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! TimelineCell
        let tweet = replyTweets[indexPath.item]
        cell.tweet = tweet
        cell.avatarView.image = imageDict[tweet.id] ?? UIImage(named: "egg")
        return cell
    }
}

extension TweetThreadViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected tweet")
    }
}

// TODO fix this
private struct Constants {
    static let smallCellHeight: CGFloat = 100
    static let cellWidth: CGFloat = UIScreen.main.bounds.width
    static let cellIdentifier = "cellId"
}
