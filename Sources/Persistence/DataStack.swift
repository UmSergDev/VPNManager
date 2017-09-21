//
//  DataStack.swift
//  VPNManager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation
import CoreData

class DataStack {
    
    typealias Completion = (Error?)->()
    var managedObjectContext: NSManagedObjectContext! = nil
    
    private(set) var initialized = false
    
    func configure(completion: @escaping Completion) {
        
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            guard error == nil else {
                completion(error)
                return
            }
            self.managedObjectContext = self.persistentContainer.viewContext
            
            self.initialized = true
            completion(nil)
        })
    }
    
    private var persistentContainer = NSPersistentContainer(name: "Model")
    
    /*
     func saveContext () {
     let context = persistentContainer.viewContext
     if context.hasChanges {
     do {
     try context.save()
     } catch {
     // Replace this implementation with code to handle the error appropriately.
     // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
     let nserror = error as NSError
     fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
     }
     }
     }
     */
}
