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
        TweetDataManager.shared.fetchTimeline { result in
            switch result {
            case .success(let timeline):
                self.tweets = timeline.timeline
                self.collectionView.reloadData()
                for tweet in timeline.timeline {
                    print(tweet)
                }
            case .failure(_):
                print("todo show an empty state showing that tweets failed to load")
            }
        }
        buildCollectionView()
	}
    
    private var tweets: [Tweet] = []
    
    // todo consider if this should be split out to custom view
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: Constants.cellWidth, height: Constants.smallCellHeight)
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    }()
    
    private func buildCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
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

// MARK: UiCollectionViewDataSource

extension TimelineViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(tweets.count)
        return tweets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // todo don't force unwrap
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! TimelineCell
        cell.tweet = tweets[indexPath.item]
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension TimelineViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("todo show the tweet thread")
        print(tweets[indexPath.item].content)
    }
}

private struct Constants {
    static let smallCellHeight: CGFloat = 100
    static let cellWidth: CGFloat = UIScreen.main.bounds.width
    static let cellIdentifier = "cellId"
}

