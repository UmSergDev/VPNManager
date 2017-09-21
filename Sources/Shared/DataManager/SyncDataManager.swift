//
//  SyncBaseDataManager.swift
//  VPNManager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation
import CoreData

class SyncDataManager<T: NSManagedObject>: DataManager<T> {
    
    override func fetch<M: DataModel>(with predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [M]  where M.T == T {
        
        var fetchedModels: [M]?
        
        context.performAndWait {
            fetchedModels = super.fetch(with: predicate, sortDescriptors: sortDescriptors)
        }
        return fetchedModels!
    }
    
    override func create<M: DataModel>() -> M where M.T == T {

        var model: M?
        
        context.performAndWait {
            model = super.create() as M
        }
        
        return model!
    }
    
    override func get<M: DataModel>(byID ID: String) -> M? where M.T == T {
        
        var model: M?
        
        context.performAndWait {
            model = super.get(byID: ID)
        }
        
        return model!
    }
    
    override func delete<M: DataModel>(model: M) throws {
        
        var outerError: Error?
        
        context.performAndWait {
            do {
                try super.delete(model: model)
            }
            catch {
                outerError = error
            }
        }
        
        if let error = outerError {
            throw error
        }
    }
    
    override func save<M: DataModel>(model: M) throws  {
        
        var outerError: Error?
        
        context.performAndWait {
            do {
                try super.save(model: model)
            }
            catch {
                outerError = error
            }
        }
        
        if let error = outerError {
            throw error
        }
    }
}
