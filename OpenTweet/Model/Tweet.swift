//
//  Tweet.swift
//  OpenTweet
//
//  Created by Mike Griffin on 8/12/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import Foundation

struct Tweet: Codable {
    let id: String
    let author: String
    let avatar: String?
    let content: String
    let inReplyTo: String?
    let date: String
}
