//
//  DashboardConfiguration.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

protocol EditorDelegateProvider {
    var editorDelegate: EditorModuleDelegate? { get }
}

class DashboardConfiguration: ModuleConfiguration, EditorDelegateProvider {

    internal var editorDelegate: EditorModuleDelegate?
    var connectionDataManager: DataManager<Connection>! = nil //di
    
    func configure(controller: UIViewController, with parameter: AnyObject?) -> Bool {
        
        guard let presenter = controller as? DashboardPresenter else {
            return false
        }
        
        editorDelegate = presenter
        
        let interactor = DashboardInteractor()
        interactor.output = presenter
        interactor.connectionDataManager = connectionDataManager
        presenter.interactor = interactor
        
        let viewAdaptor = DashboardViewAdapter(with: presenter.view as! UITableView)
        presenter.userInterface = viewAdaptor
        viewAdaptor.eventHandler = presenter

        return true
    }
}
