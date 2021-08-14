//
//  Date+Ext.swift
//  OpenTweet
//
//  Created by Mike Griffin on 8/14/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import Foundation

extension String {
    func timelineDisplayDate() -> String {
        let dateFormatter = ISO8601DateFormatter()
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        let stringFormatter = DateFormatter()
        stringFormatter.dateFormat = "M/d/yy"
        return stringFormatter.string(from: date)
    }
}
