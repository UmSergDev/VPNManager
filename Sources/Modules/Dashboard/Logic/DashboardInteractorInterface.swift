//
//  DashboardInteractorInterface.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation

protocol DashboardInteractorInput: class {
    func connectionList() -> [ConnectionListItem]
    func setSelectedConnection(with ID: String, completion: @escaping (Error?) -> ())
    func setConnection(to enabled: Bool)
    func uninstallVPNConfiguration()
}

protocol DashboardInteractorOutput: class {
    func connectionDidChange(to state: ConnectionState)
    func didReceive(error: Error)
}
