//
//  ViewController.swift
//  OpenTweet
//
//  Created by Olivier Larivain on 9/30/16.
//  Copyright © 2016 OpenTable, Inc. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildSpinnerView()
        buildTableView()
        setupUI()
        // split this to another view function or something
        // TODO show a loading spinner while this loads
        TweetDataManager.shared.fetchTimeline { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let timeline):
                    self.tweets = timeline.timeline
                    //print(TweetDataManager.shared.replyMap)
                    self.spinner.willMove(toParent: nil)
                    self.spinner.view.removeFromSuperview()
                    self.spinner.removeFromParent()
                    self.tableView.reloadData()
                case .failure(_):
                    print("todo show an empty state showing that tweets failed to load")
                // consider if build collection view should only happen in the success case
                // or if my collection should track empty state and display accordingly
                }
            }
        }
    }
    
    private var tweets: [Tweet] = []
    private let spinner = SpinnerViewController()

    
    private var tableView = UITableView()
    
    private func buildSpinnerView() {
        spinner.view.frame = view.frame
        addChild(spinner)
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
    
    private func setupUI() {
        view.backgroundColor = .primaryBackground
        navigationController?.navigationBar.topItem?.title = "Timeline"
    }
    
    private func buildTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TimelineCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// MARK: UITableViewDataSource

extension TimelineViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! TimelineCell
        cell.tweet = tweets[indexPath.item]
        ImageManager.shared.fetchImage(tweets[indexPath.item].avatar) { image in
            DispatchQueue.main.async {
                cell.avatarView.image = image
            }
        }
        return cell
    }
}

// MARK: UITableViewDelegate

extension TimelineViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTweet = tweets[indexPath.item]
        var mainTweet: Tweet
        var replyTweets: [Tweet]
        var imageDict: [String: UIImage] = [:]
        if let replyToId = selectedTweet.inReplyTo, let replyToTweet = TweetDataManager.shared.allTweets[replyToId] {
            mainTweet = replyToTweet
            replyTweets = [selectedTweet]
            let allTweets = [mainTweet, selectedTweet]
            setImageDict(&imageDict, tweets: allTweets)
        } else {
            mainTweet = selectedTweet
            replyTweets = TweetDataManager.shared.replyMap[selectedTweet.id] ?? []
            var allTweets = [mainTweet]
            allTweets.append(contentsOf: replyTweets)
            setImageDict(&imageDict, tweets: allTweets)
        }
        navigationController?.pushViewController(TweetThreadViewController(mainTweet: mainTweet, replyTweets: replyTweets, imageDict: imageDict), animated: true)
    }
}

private func setImageDict(_ dict: inout [String: UIImage], tweets: [Tweet]) {
    for tweet in tweets {
        dict[tweet.id] = ImageManager.shared.imageCache.object(forKey: NSString(string: tweet.avatar ?? "")) ?? UIImage(named: "egg")
    }
}

private struct Constants {
    static let smallCellHeight: CGFloat = 100
    static let cellWidth: CGFloat = UIScreen.main.bounds.width
    static let cellIdentifier = "cellId"
}

