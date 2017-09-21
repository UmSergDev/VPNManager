//
//  ConnectionDataModel.swift
//  VPNManager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation
import CoreData

fileprivate let HiddenPasswordPlaceholder = "#PASSWORD_IS_HIDDEN#"

class ConnectionDataModel: ConnectionData, DataModel {
    
    var connectionID: String
    var server: String
    var remoteID: String
    var localID: String
    var title: String
    var username: String
    var password: String
    var passwordKeychainData: Data?
    
    let managedObject: Connection
    var passwordChanged: Bool {
        return password != HiddenPasswordPlaceholder
    }
    
    public required init(with managedObject: Connection) {
        self.managedObject = managedObject
        
        connectionID = managedObject.objectID.uriRepresentation().absoluteString
        server = managedObject.server ?? ""
        remoteID = managedObject.remoteID ?? ""
        localID = managedObject.localID ?? ""
        title = managedObject.title ?? ""
        username = managedObject.username ?? ""
        password = HiddenPasswordPlaceholder
        passwordKeychainData = managedObject.password as Data?
    }
    
    internal func updateManagedObject() {
        managedObject.server = server
        managedObject.localID = localID
        managedObject.remoteID = remoteID
        managedObject.title = title
        managedObject.username = username
        managedObject.password = passwordKeychainData as NSData?
    }
}
