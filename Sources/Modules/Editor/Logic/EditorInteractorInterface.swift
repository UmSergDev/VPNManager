//
//  EditorInteractorInterface.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation

protocol ConnectionData: class {
    var connectionID: String {get set}
    var server: String {get set}
    var remoteID: String {get set}
    var localID: String {get set}
    var title: String {get set}
    var username: String {get set}
    var password: String {get set}
    var passwordKeychainData: Data? {get}
}

protocol EditorInteractorInput: class {
    func createConnection() -> ConnectionData
    func save(connection: ConnectionData) -> Bool
    func connection(from ID: String) -> ConnectionData?
    func delete(connection: ConnectionData)
}

protocol EditorInteractorOutput: class {

}
