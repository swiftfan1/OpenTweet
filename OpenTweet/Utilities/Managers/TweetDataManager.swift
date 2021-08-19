//
//  TweetDataManager.swift
//  OpenTweet
//
//  Created by Mike Griffin on 8/12/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import Foundation

final class TweetDataManager {
    static let shared = TweetDataManager()
    let dataQueue = DispatchQueue(label: QueueLabel.data)
    var replyMap: [String: [Tweet]] = [:]
    var allTweets: [String: Tweet] = [:]
    
    private init() {}
    
    func fetchTimeline(completed: @escaping (Result<Timeline, Error>) -> Void) {
        dataQueue.async {
            do {
                if let bundlePath = Bundle.main.path(forResource: FileName.timeline,
                                                     ofType: "json") {
                    if let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                        do {
                            let decodedData = try JSONDecoder().decode(Timeline.self, from: jsonData)
                            self.allTweets = decodedData.timeline.reduce(into: [String: Tweet]()) {
                                $0[$1.id] = $1
                            }
                            for tweet in decodedData.timeline {
                                ImageManager.shared.fetchImage(tweet.avatar, completed: nil)
                                if let reply = tweet.inReplyTo {
                                    if var replies = self.replyMap[reply] {
                                        replies.append(tweet)
                                        self.replyMap[reply] = replies
                                    } else {
                                        self.replyMap[reply] = [tweet]
                                    }
                                }
                            }
                            completed(.success(decodedData))
                        } catch {
                            completed(.failure(error))
                        }
                    } else {
                        print("todo custom error here")
                    }
                } else {
                    print("todo custom error here")
                }
            } catch {
                completed(.failure(error))
            }
        }
    }
}
