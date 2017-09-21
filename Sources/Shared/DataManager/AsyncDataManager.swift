//
//  AsyncBaseDataManager.swift
//  VPNManager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation
import CoreData

// untested!

class AsyncBaseDataManager<T: NSManagedObject> {
    
    let baseManager: DataManager<T>
    
    public init(baseManager: DataManager<T>) {
        self.baseManager = baseManager
    }
    
    func fetch<M: DataModel>(with predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]) -> Future<[M]> where M.T == T {
        
        let future = Future<[M]>()
        
        baseManager.context.perform {
            future.result = self.baseManager.fetch(with: predicate, sortDescriptors: sortDescriptors)
        }
        
        return future
    }
    
    func create<M: DataModel>() -> Future<M> where M.T == T {
        
        let future = Future<M>()
        
        baseManager.context.perform {
            let result: M = self.baseManager.create()
            future.result = result
        }
        
        return future
    }
    
    func get<M: DataModel>(byID ID: String) -> Future<M?> where M.T == T {
        
        let future = Future<M?>()
        
        baseManager.context.perform {
            let result: M? = self.baseManager.get(byID: ID)
            future.result = result
        }
        
        return future
    }
    
    func delete<M: DataModel>(model: M) -> Future<Error?> {
        
        let future = Future<Error?>()
        
        baseManager.context.perform {
            do {
                try self.baseManager.delete(model: model)
                future.result = nil
            }
            catch {
                future.result = error
            }
        }
        
        return future
    }
    
    func save<M: DataModel>(model: M) -> Future<Error?> {
        
        let future = Future<Error?>()
        
        baseManager.context.perform {
            do {
                try self.baseManager.save(model: model)
                future.result = nil
            }
            catch {
                future.result = error
            }
        }
        
        return future
    }
}
