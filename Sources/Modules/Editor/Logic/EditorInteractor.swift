//
//  EditorInteractor.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

class EditorInteractor: NSObject, EditorInteractorInput {
    var output: EditorInteractorOutput!
    
    var connectionDataManager: DataManager<Connection>! = nil // di
    
    func createConnection() -> ConnectionData {
        let model: ConnectionDataModel = connectionDataManager.create()
        return model
    }
    
    func save(connection: ConnectionData) -> Bool {
        
        guard isValid(data: connection) else {
            return false
        }

        guard let model = connection as? ConnectionDataModel else {
            return false
        }
        
        if model.passwordChanged {
            // Password is being securely saving in Keychain, in CoreData -- reference only
            let keychainHelper = KeychainHelper(key: model.objectID)
            keychainHelper.set(value: model.password)
            model.passwordKeychainData = keychainHelper.getReference()
        }

        do {
            try connectionDataManager.save(model: model)
            try connectionDataManager.context.saveIfNeeded()
        }
        catch {
            return false
        }
        
        return true
    }
    
    func connection(from ID: String) -> ConnectionData? {
        let model: ConnectionDataModel? = connectionDataManager.get(byID: ID)
        return model
    }
    
    func delete(connection: ConnectionData) {
        if let model = connection as? ConnectionDataModel {
            do {
                try connectionDataManager.delete(model: model)
                try connectionDataManager.save(model: model)
            }
            catch {
                //MARK: todo handle else and try
            }
        }
    }
    
    func isValid(data: ConnectionData) -> Bool {
        
        guard !data.title.isEmpty &&
            !data.server.isEmpty &&
            !data.remoteID.isEmpty &&
            !data.username.isEmpty &&
            !data.password.isEmpty
            else {
                return false
        }
        
        guard let _ = NSURL(string: data.server) else {
            return false
        }
        
        return true
    }
}
