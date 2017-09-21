//
//  ModuleDescription.swift
//  Ledger
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

protocol ModuleDescription {
    static var moduleName: String { get }
    associatedtype ModuleInterface
    static func instantiate() -> ModuleInterface
}

extension ModuleDescription {
    
    static func instantiate() -> ModuleInterface {
        let storyboard = UIStoryboard(name: moduleName, bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        return controller as! ModuleInterface
    }
    
    static func localizedString(for key: String) -> String {
        return NSLocalizedString(key, tableName: moduleName, comment: key)
    }
}
