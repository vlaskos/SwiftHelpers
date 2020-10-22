//
//  Calendar.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import Foundation

extension Calendar {
    func isDateInCurrentMonth(_ date: Date) -> Bool {
        let now = Date()
        let dcNow = dateComponents([.month, .year], from: now)
        let dcDate = dateComponents([.month, .year], from: date)
        
        if let month1 = dcNow.month, let month2 = dcDate.month,
            let year1 = dcNow.year, let year2 = dcDate.year,
            month1 == month2, year1 == year2 {
            return true
        }
        return false
    }
    
    /// Ignore hours, that is 2019/12/31 23:59 and 2020/01/01 00:01
    /// will return 1 day difference.
    /// positive -> from < to, negative -> from > to, 0 -> same days.
    func daysBetweenIgnoreHours(from fDate: Date, to tDate: Date) -> Int? {
        return componentsBetweenDatesIgnoreHours(
            from: fDate, to: tDate, components: [.day]).day
    }
    
    private func componentsBetweenDatesIgnoreHours(
        from fDate: Date, to tDate: Date,
        components: Set<Component>) -> DateComponents {
        return dateComponents(components,
            from: startOfDay(for: fDate),
            to: startOfDay(for: tDate))
    }
}

extension Calendar {
    func monthsBetween(from fDate: Date, to tDate: Date) -> Int {
        var fdc = DateComponents()
        fdc.year = component(.year, from: fDate)
        fdc.month = component(.month, from: fDate)
        fdc.day = 1
        
        var tdc = DateComponents()
        tdc.year = component(.year, from: tDate)
        tdc.month = component(.month, from: tDate)
        tdc.day = 1
        
        let rdc = dateComponents([.month], from: fdc, to: tdc)
        return rdc.month!
    }
}

