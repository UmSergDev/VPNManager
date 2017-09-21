//
//  NSManagedObjectContext.swift
//  Ledger
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    public func makeObject<A: NSManagedObject>() -> A {
        return NSEntityDescription.insertNewObject(forEntityName: A.entityName(), into: self) as! A
    }
    
    
    func saveIfNeeded() throws {
        guard hasChanges else {
            return
        }
        try save()
    }

}
