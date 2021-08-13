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
		// Do any additional setup after loading the view, typically from a nib.
        TweetDataManager.shared.fetchTimeline { result in
            switch result {
            case .success(let timeline):
                for tweet in timeline.timeline {
                    print(tweet)
                }
            case .failure(_):
                print("todo show an empty state showing that tweets failed to load")
            }
        }
	}

}

