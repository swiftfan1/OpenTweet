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
        buildCollectionView()
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
                    self.collectionView.reloadData()
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

    
    // todo consider if this should be split out to custom view
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.estimatedItemSize = CGSize(width: Constants.cellWidth, height: Constants.smallCellHeight)
        //layout.itemSize = CGSize(width: Constants.cellWidth, height: Constants.smallCellHeight)
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    }()
    
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
    
    private func buildCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .secondaryBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TimelineCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// MARK: UICollectionViewDataSource

extension TimelineViewController: UICollectionViewDataSource {
    //    func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        return 1
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(tweets.count)
        return tweets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // todo don't force unwrap
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! TimelineCell
        cell.tweet = tweets[indexPath.item]
        ImageManager.shared.fetchImage(tweets[indexPath.item].avatar) { image in
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
        }
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension TimelineViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("todo show the tweet thread")
        print(tweets[indexPath.item].content)
        let selectedTweet = tweets[indexPath.item]
        var mainTweet: Tweet
        var replyTweets: [Tweet]
        if let replyToId = selectedTweet.inReplyTo, let replyToTweet = TweetDataManager.shared.allTweets[replyToId] {
            mainTweet = replyToTweet
            replyTweets = [selectedTweet]
        } else {
            mainTweet = selectedTweet
            replyTweets = TweetDataManager.shared.replyMap[selectedTweet.id] ?? []
        }
        navigationController?.pushViewController(TweetThreadViewController(mainTweet: mainTweet, replyTweets: replyTweets), animated: true)
    }
}

private struct Constants {
    static let smallCellHeight: CGFloat = 100
    static let cellWidth: CGFloat = UIScreen.main.bounds.width
    static let cellIdentifier = "cellId"
}

