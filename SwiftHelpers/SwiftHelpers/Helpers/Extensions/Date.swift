//
//  Date.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import Foundation

extension Date {
    
    func differenceInDaysWithDate(date: Date) -> Int {
        let calendar = Calendar.current
        
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: date)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day ?? 0
    }
    
    func isInSameMonth(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .month)
    }
    
    /// Returns the first moment of this day
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    func days(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.day], from: sinceDate, to: self).day
    }
    
    func add(_ unit: Calendar.Component, value: Int) -> Date? {
        return Calendar.current.date(byAdding: unit, value: value, to: self)
    }
    
    func isDateInDate(_ date: Date) -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        
        let dcSelf = calendar.dateComponents([.day, .month, .year], from: self)
        let dcDate = calendar.dateComponents([.day, .month, .year], from: date)
        
        if let day1 = dcSelf.day, let day2 = dcDate.day,
            let month1 = dcSelf.month, let month2 = dcDate.month,
            let year1 = dcSelf.year, let year2 = dcDate.year,
            day1 == day2, month1 == month2, year1 == year2 {
            return true
        }
        return false
    }
    
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)) ~= self
    }
    
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func isEqual(to date: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: self, to: date)
        if diff.day == 0 {
            return true
        }
        return false
    }
    
    func isStartOfMonth() -> Bool {
        let startDay = self.startOfMonth()
        guard self.isEqual(to: startDay) else { return false }
        return true
    }
    
    func isEndOfMonth() -> Bool {
        let endDay = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
        guard self.isEqual(to: endDay) else { return false }
        return true
    }
    
    func daysToDate(_ endDate: Date) -> [Date] {
        var dates: [Date] = []
        let cal = Calendar.current
        var days = DateComponents()
        var dayCount = 0
        while true {
            days.day = dayCount
            let date: Date = cal.date(byAdding: days, to: self)!
            if date.compare(endDate) == .orderedDescending {
                break
            }
            dayCount += 1
            dates.append(date)
        }
        
        return dates
    }
    
    func isSameDayAs(_ date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
}

