//
//  ModuleAssembler.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

public class ConfigurationManager {
    
    typealias Container = LinkedContainer<ModuleConfiguration>?
    
    private var firstContainer: Container
    private var parameters = [String: AnyObject]()
    
    init() {
        ConfigurationManager.swizzleMethods()
    }
    
    public func register(configuration: ModuleConfiguration) {
        let container = LinkedContainer(with: configuration)
        let previousContainer = firstContainer
        firstContainer = container
        firstContainer?.nextContainer = previousContainer
    }
    
    fileprivate func store(parameter: AnyObject?, for viewController: UIViewController) {
        let type = type(of: viewController)
        let key = NSStringFromClass(type)
        parameters[key] = parameter
    }
    
    fileprivate func configure(viewController: UIViewController) {
        
        viewController.configurationManager = self
        var container = firstContainer
        let type = type(of: viewController)
        let key = NSStringFromClass(type)

        repeat {
            if let configurator = container?.object {
                if configurator.configure(controller: viewController, with: parameters[key]) {
                    break
                }
            }
            container = container?.nextContainer
        } while container != nil
    }
    
    static var methodsSwizzled = false
    static private func swizzleMethods() {
        
        guard methodsSwizzled == false else {
            return
        }
        methodsSwizzled = true
        
        swizzle(method1: #selector(UIViewController.loadView),
                method2: #selector(UIViewController.configuration_apply),
                inClass: UIViewController.self)
        
        swizzle(method1: #selector(UIViewController.prepare(for:sender:)),
                method2: #selector(UIViewController.configuration_prepare(for:sender:)),
                inClass: UIViewController.self)
    }
}

extension UIViewController {
    
    private struct Keys {
        static var configurationManager = "viper_configurationManager"
    }
    
    var configurationManager: ConfigurationManager? {
        get {
            return objc_getAssociatedObject(self, &Keys.configurationManager) as? ConfigurationManager
        }
        set {
            objc_setAssociatedObject(self, &Keys.configurationManager, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc fileprivate func configuration_apply() {
        
        if viewIfLoaded != nil {
            return
        }
        
        configuration_apply() // actually `loadView`
        guard let configurationManager = self.configurationManager ?? navigationController?.configurationManager else {
            return
        }
        
        configurationManager.configure(viewController: self)
    }
    
    @objc fileprivate func configuration_prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let parameter = sender as AnyObject?
        configurationManager?.store(parameter: parameter, for: segue.destination)
        configuration_prepare(for: segue, sender: sender)  // actually `prepare for segue`
    }
}
