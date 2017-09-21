//
//  DashboardUIInterface.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation

struct UIConnection {
    let title: String
    
    public init(title: String) {
        self.title = title
    }
}

protocol DashboardUIInterface: class {
    func show(connectionEnabled: Bool) 
    func show(status: String)
    func show(connections: [UIConnection])
    func show(selectionAt index: Int)
    func setConnection(allowed: Bool)
}

protocol DashboardUIEvents: class {
    func didSelectConnection(at index: Int)
    func didChangeEnabledSwitch(to state: Bool)
    func didTapEditConnection(at index: Int)
    func didTapAddConnection()
}
