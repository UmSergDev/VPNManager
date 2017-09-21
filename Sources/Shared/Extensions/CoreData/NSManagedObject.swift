//
//  NSManagedObject.swift
//  Ledger
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    class func entityName() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
}

