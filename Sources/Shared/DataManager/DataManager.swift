//
//  BaseDataManager.swift
//  VPNManager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation
import CoreData

enum DataManagerError: Swift.Error {
    case incorrectContext
}

class BaseDataManager {
    
    let context: NSManagedObjectContext
    
    
    public init(context: NSManagedObjectContext) {
        self.context = context
    }
}

class DataManager<T: NSManagedObject>: BaseDataManager {
    
    func fetch<M: DataModel>(with predicate: NSPredicate? = nil,
               sortDescriptors: [NSSortDescriptor]? = nil) -> [M]  where M.T == T {
        
        var fetchedModels = [M]()

        let request = T.fetchRequest()
        request.sortDescriptors = sortDescriptors
        request.predicate = predicate
        
        guard
            let result = try? request.execute(),
            let managedObjects = result as? [T]
        else {
            return []
        }
        
        for managedObject in managedObjects {
            let model = M(with: managedObject)
            fetchedModels.append(model)
        }
        
        return fetchedModels
    }
    
    func count(with predicate: NSPredicate?) -> Int {
        
        let request = T.fetchRequest()
        request.includesSubentities = false
        
        if let count = try? context.count(for: request) {
            return count
        }
        
        return 0
    }
    
    func create<M: DataModel>() -> M where M.T == T {
        
        let managedObject: T = context.makeObject()
        return M(with: managedObject)
    }
    
    func get<M: DataModel>(byID ID: String) -> M? where M.T == T {
        
        let coordinator = context.persistentStoreCoordinator!
        
        guard let URI = URL(string: ID) else {
            return nil
        }
        
        guard let objectID = coordinator.managedObjectID(forURIRepresentation: URI) else {
            return nil
        }
        
        if let managedObject = try? context.existingObject(with: objectID),
           let typedManagedObject = managedObject as? T {
            let model = M(with: typedManagedObject)
            return model
        }
        
        return nil
    }
    
    func delete<M: DataModel>(model: M) throws {
        
        let managedObject = model.managedObject
        
        guard managedObject.managedObjectContext == context else {
            throw DataManagerError.incorrectContext
        }
        
        context.delete(managedObject)
    }
    
    func save<M: DataModel>(model: M) throws  {
    
        let managedObject = model.managedObject

        guard managedObject.managedObjectContext == context else {
            throw DataManagerError.incorrectContext
        }
        
        model.updateManagedObject()
    }

}
