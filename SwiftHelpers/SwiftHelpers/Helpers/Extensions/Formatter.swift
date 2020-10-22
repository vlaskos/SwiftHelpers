//
//  Formatter.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let dayMonthDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()
    
    static let dayMonthYearDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()
    
    static let weekDayDayMonth: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d MMM"
        dateFormatter.locale = Locale(identifier: "fr-FR")
        return dateFormatter
    }()
    
    static let hoursMinutes: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()
    
}

extension NumberFormatter {
    
    static let decimal: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        return formatter
    }()
}

