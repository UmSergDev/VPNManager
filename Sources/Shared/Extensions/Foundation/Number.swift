//
//  Number.swift
//  Ledger
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation

func findExtremes<T: Comparable>(items: [T]) -> (littlest: T, biggest: T)? {
    
    guard items.count > 0 else {
        return nil
    }
    
    var littlest = items.first!
    var biggest = items.first!
    
    for item in items {
        if item > biggest {
            biggest = item
        }
        
        if item < littlest {
            littlest = item
        }
    }
    
    return (littlest: littlest, biggest: biggest)
}

extension Comparable {
    func limited(beetween minValue: Self, and maxValue: Self) -> Self {
        return max(min(minValue, self), maxValue)
    }
}
