//
//  AppDelegate.swift
//  SolarVPN
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

@UIApplicationMain class AppDelegate: NSObject {

    var window: UIWindow?
    let manager = ConfigurationManager()

    let dashboardConfiguration = DashboardConfiguration()
    let editingConfiguration = EditingConfiguration()
    let creationConfiguration = CreationConfiguration()
    let dataStack = DataStack()
}

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        dataStack.configure { (error) in
//            if let error = error { Log.error(error) }
            self.initialize()
        }
        
        return true
    }
    
    func initialize() {
        
        let connectionManager = SyncDataManager<Connection>(context: dataStack.managedObjectContext)
        
        dashboardConfiguration.connectionDataManager = connectionManager
        editingConfiguration.connectionDataManager = connectionManager
        creationConfiguration.connectionDataManager = connectionManager
        
        editingConfiguration.delegateProvider = dashboardConfiguration
        creationConfiguration.delegateProvider = dashboardConfiguration
        
        manager.register(configuration: dashboardConfiguration)
        manager.register(configuration: editingConfiguration)
        manager.register(configuration: creationConfiguration)
        
        window = Dashboard.startModuleHierarchy(with: manager)
        
    }
}
