//
//  EditorInterface.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation

protocol EditorModuleInterface: class {
    func prepareFormForCreation()
    func prepareFormForEditing(connectionID: String)
}

protocol EditorModuleDelegate: class {
    func didDelete(connectionID: String)
    func didEdit(connectionID: String)
    func didAdd()
}
