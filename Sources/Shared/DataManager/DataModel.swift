//
//  DataModel.swift
//  VPNManager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation
import CoreData

protocol DataModel {
    associatedtype T: NSManagedObject
    var managedObject: T { get }
    init(with managedObject: T)
    func updateManagedObject()
}

extension DataModel {
    var objectID: String {
        get {
            return managedObject.objectID.uriRepresentation().absoluteString
        }
    }
}
