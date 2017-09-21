//
//  RootModule.swift
//  Ledger
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

protocol RootModule: ModuleDescription {
    static func startModuleHierarchy(with manager: ConfigurationManager) -> UIWindow
}

extension RootModule {
    
    static func startModuleHierarchy(with manager: ConfigurationManager) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: moduleName, bundle: nil)
        let controller = storyboard.instantiateInitialViewController()!
        controller.configurationManager = manager
        window.rootViewController = controller
        window.makeKeyAndVisible()
        return window
    }
}
