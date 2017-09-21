//
//  String.swift
//  Ledger
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation

//http://stackoverflow.com/a/30404532

extension String {
    func range(from NSRange: NSRange) -> Range<String.Index>? {
        
        guard NSRange.location != NSNotFound else {
            return nil
        }
        
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: NSRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: NSRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else {
                return nil
            }
        
        return from ..< to
    }
}
