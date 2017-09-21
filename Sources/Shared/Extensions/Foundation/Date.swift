//
//  Date.swift
//  Ledger
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation

extension Date {
    func withoutTime() -> NSDate {
        let timeZone = NSTimeZone.local
        let timeIntervalWithTimeZone = self.timeIntervalSinceReferenceDate + Double(timeZone.secondsFromGMT())
        let timeInterval = floor(timeIntervalWithTimeZone / 86400) * 86400
        return NSDate(timeIntervalSinceReferenceDate: timeInterval)
    }
}
