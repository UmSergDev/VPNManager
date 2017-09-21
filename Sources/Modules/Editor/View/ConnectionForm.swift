//
//  ConnectionForm.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation

class ConnectionForm: Form {
        
    let type = GenericRow(labelText: Editor.localizedString(for: "connection-type"), detailText: "IKEv2")
    let title = TextFieldRow(titleText: Editor.localizedString(for: "title"))
    let serverAddress = TextFieldRow(titleText: Editor.localizedString(for: "server-name"))
    let localID = TextFieldRow(titleText: Editor.localizedString(for: "remote-id"))
    let remoteID = TextFieldRow(titleText: Editor.localizedString(for: "local-id"))
    
    let loginType = GenericRow(labelText: Editor.localizedString(for: "auth-method"), detailText: "Password")
    let username = TextFieldRow(titleText: Editor.localizedString(for: "username"))
    let password = TextFieldRow(titleText: Editor.localizedString(for: "password"))
    
    let delete = GenericRow {
        $0.textLabel?.text = Editor.localizedString(for: "delete")
        $0.textLabel?.textColor = .red
    }
    
    init(includeDeleteButton: Bool) {
        
        let requiredPlaceholder = Editor.localizedString(for: "required")
        for row in [title, serverAddress, remoteID, username, password] {
            row.placeholderText = requiredPlaceholder
        }
        
        
        for row in [serverAddress, remoteID, localID, username] {
            row.disableAutoreplace = true
        }
        
        password.isSecureTextEntry = true
        serverAddress.keyboardType = .URL
        
        super.init()
        self.sections = makeSections(includeDeleteButton: includeDeleteButton)
    }
    
    func makeSections(includeDeleteButton: Bool) -> [GenericSection] {
        let type = GenericSection(rows: [self.type])
        let main = GenericSection(rows: [title, serverAddress, remoteID, localID])
        let login = GenericSection(rows: [loginType, username, password])
        let delete = GenericSection(rows: [self.delete])
        
        if includeDeleteButton {
            return [type, main, login, delete]
        }
        
        return [type, main, login]
    }
}

extension ConnectionForm {
    func fill(with data: ConnectionData) {
        self.title.textFieldValue = data.title
        self.localID.textFieldValue = data.localID
        self.remoteID.textFieldValue = data.remoteID
        self.serverAddress.textFieldValue = data.server
        self.username.textFieldValue = data.username
        self.password.textFieldValue = data.password
    }
    
    func fill(data: ConnectionData) {
        data.title = title.textFieldValue
        data.localID = localID.textFieldValue
        data.remoteID = remoteID.textFieldValue
        data.server = serverAddress.textFieldValue
        data.password = password.textFieldValue
        data.username = username.textFieldValue
    }
}
