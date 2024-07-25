//
//  DateFormatter+Extension.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 23/07/24.
//

import Foundation

extension DateFormatter {
    static var monthYearDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter
    }
}
