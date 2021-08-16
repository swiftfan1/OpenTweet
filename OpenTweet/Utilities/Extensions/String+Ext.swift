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
        // TODO get this formatter out of the function...I'm declaring it every time
        let dateFormatter = ISO8601DateFormatter()
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        let stringFormatter = DateFormatter()
        stringFormatter.dateFormat = "M/d/yy"
        return stringFormatter.string(from: date)
    }
}
