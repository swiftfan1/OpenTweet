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
    }
    
    init(mainTweet: Tweet, replyTweets: [Tweet]) {
        self.mainTweet = mainTweet
        self.replyTweets = replyTweets
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mainTweet: Tweet
    private let replyTweets: [Tweet]
}
