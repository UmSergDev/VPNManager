//
//  DashboardInteractor.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit
import NetworkExtension

fileprivate let SelectedConnectionKeyName = "SelectedConnectionKeyName"

class DashboardInteractor: NSObject, DashboardInteractorInput {

    var connectionDataManager: DataManager<Connection>! = nil //di

    enum ListError: Error {
        case textError(text: String)
    }
    
    var output: DashboardInteractorOutput?
    var selectedConnectionID: String?
    
    let VPN = NEVPNManager.shared()
    
    override init() {
        selectedConnectionID = UserDefaults.standard.object(forKey: SelectedConnectionKeyName) as? String
        
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(DashboardInteractor.connectionStatusDidChange(notification:)), name: NSNotification.Name.NEVPNStatusDidChange, object: nil)
    }
    
    func connectionStatusDidChange(notification: NSNotification) {
        
        DispatchQueue.main.async {
            var state = ConnectionState.disconnected
            
            switch self.VPN.connection.status {
            case .disconnected, .invalid:
                state = .disconnected
            case .connected:
                state = .connected
            case .connecting, .reasserting:
                state = .connecting
            case .disconnecting:
                state = .disconnecting
            }
            
            self.output?.connectionDidChange(to: state)
        }
    }
    
    func connectionList() -> [ConnectionListItem] {
        
        var listItems = [ConnectionListItem]()
//        let sortDdscriptor = NSSortDescriptor()
        let models: [ConnectionDataModel] = connectionDataManager.fetch()
        
        let selected = models.filter { (connection) -> Bool in
            return connection.objectID == selectedConnectionID
        }.first ?? models.first
        
        for connection in models {
            let title = connection.title
            let selected = selected?.objectID == connection.objectID
            listItems.append(ConnectionListItem(ID: connection.objectID, title: title, selected: selected))
        }
        
        return listItems
    }
    
    func setSelectedConnection(with ID: String, completion: @escaping (Error?) -> ()) {
        
        guard let connection: ConnectionDataModel = connectionDataManager.get(byID: ID) else {
            let error = ListError.textError(text: "Could not find the connection")
            completion(error)
            return
        }
        
        VPN.isEnabled = true
        
        VPN.loadFromPreferences { (error) in
            if let error = error {
                self.output?.didReceive(error: error)
            }
            
            self.VPN.protocolConfiguration = connection.connectionProtocol()
            
            self.VPN.saveToPreferences { (error) in
                
                if error != nil {
                    completion(error)
                    return
                }
                
                self.selectedConnectionID = ID
                UserDefaults.standard.set(ID, forKey: SelectedConnectionKeyName)
                completion(nil)
            }
        }
    }
    
    func setConnection(to enabled: Bool) {

        VPN.loadFromPreferences { (error) in

            if error != nil {
                self.output?.didReceive(error: error!)
                return
            }

            let status = self.VPN.connection.status
            let connectionActive = status == .connected || status == .connecting || status == .reasserting
            
            if enabled && connectionActive {
                return
            }
            
            if !enabled && !connectionActive {
                return
            }

            do {
                if enabled {
                    try self.VPN.connection.startVPNTunnel()
                } else
                {
                    self.VPN.connection.stopVPNTunnel()
                }
            }
            catch let error {
                self.output?.didReceive(error: error)
            }
        }
    }
    
    func uninstallVPNConfiguration() {
            
        selectedConnectionID = nil
        
        VPN.removeFromPreferences { (error) in
            if error != nil {
                self.output?.didReceive(error: error!)
            }
        }
    }
}

extension ConnectionData {
    func connectionProtocol() -> NEVPNProtocolIKEv2 {
        let connection = NEVPNProtocolIKEv2()

        connection.remoteIdentifier = remoteID
        connection.localIdentifier = localID
        connection.serverAddress = server
        connection.passwordReference = self.passwordKeychainData
        connection.username = username
        
        connection.useExtendedAuthentication = true
        
        return connection
    }
}


