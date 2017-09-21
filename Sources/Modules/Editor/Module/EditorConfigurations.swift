//
//  EditorConfigurations.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

/**
 *
 * Конфигурация модуля при редактировании подключения
 *
 */

class EditingConfiguration: ModuleConfiguration {
    
    var delegateProvider: EditorDelegateProvider?
    var connectionDataManager: DataManager<Connection>! = nil //di
    
    public func configure(controller: UIViewController, with parameter: AnyObject?) -> Bool {
        
        guard let presenter = controller as? EditorPresenter else {
            return false
        }
        
        guard let ID = parameter as? String else {
            return false
        }
        
        let interactor = EditorInteractor()
        interactor.output = presenter
        interactor.connectionDataManager = connectionDataManager

        presenter.interactor = interactor
        presenter.delegate = delegateProvider?.editorDelegate
        presenter.prepareFormForEditing(connectionID: ID)
        
        return true
    }
}

/**
 *
 * Конфигурация модуля при создании подключения
 *
 */

class CreationConfiguration: ModuleConfiguration {
    
    var delegateProvider: EditorDelegateProvider?    
    var connectionDataManager: DataManager<Connection>! = nil //di
    
    public func configure(controller: UIViewController, with parameter: AnyObject?) -> Bool {
        
        guard let presenter = controller as? EditorPresenter else {
            return false
        }
        
        guard parameter == nil else {
            return false
        }
        
        let interactor = EditorInteractor()
        interactor.output = presenter
        interactor.connectionDataManager = connectionDataManager

        presenter.interactor = interactor
        presenter.delegate = delegateProvider?.editorDelegate
        presenter.prepareFormForCreation()
        
        return true
    }
}
