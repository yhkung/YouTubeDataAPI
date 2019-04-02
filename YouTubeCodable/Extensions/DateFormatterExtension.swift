//
//  DateFormatterExtension.swift
//  YoutubeDemo
//
//  Created by YH Kung on 2019/3/28.
//  Copyright © 2019 WaveRadio. All rights reserved.
//

import Foundation

extension DateFormatter {

    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

}
