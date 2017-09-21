//
//  Array.swift
//  Ledger
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

public extension CGFloat {
    
    func closest(in items: [CGFloat]) -> CGFloat {
        let items = items.sorted()
        
        if self <= items.first! {
            return items.first!
        }

        let lastIndex = items.index(before:  items.indices.endIndex)
        
        for index in items.indices {
            
            guard index != lastIndex else {
                break
            }
            
            let currentValue = items[index]
            let nextIndex = items.index(after: index)
            let nextValue = items[nextIndex]
            
            guard currentValue > self else {
                continue
            }
            
            let value = self - currentValue <= nextValue - self ? currentValue : nextValue
            
            return value
        }
        
        return items.last!
    }
}
