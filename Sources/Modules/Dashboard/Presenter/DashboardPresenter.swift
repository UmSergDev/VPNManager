//
//  DashboardPresenter.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

class DashboardPresenter: UITableViewController {
    
    var userInterface: DashboardUIInterface! 
    var interactor: DashboardInteractorInput!
    var delegate: DashboardModuleDelegate?
    
    var selectedConnectionIndex: Int? {
        didSet {
            userInterface.setConnection(allowed: selectedConnectionIndex != nil)
        }
    }
    
    var connections = [ConnectionListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard interactor != nil else {
            return // для использования этого контроллера как splash screen
        }
        
        updateConnections()
    }
    
    func updateConnections() {
        connections = interactor.connectionList()
        selectedConnectionIndex = nil
        
        for index in connections.indices {
            let connection = connections[index]
            if connection.selected {
                self.selectedConnectionIndex = index
            }
        }
        
        let UIConnections: [UIConnection] = connections.map { (listItem) -> UIConnection in
            return UIConnection(title: listItem.title)
        }
        
        userInterface.show(connections: UIConnections)
        
        if let index = selectedConnectionIndex {
            userInterface.show(selectionAt: index)
        }
    }
    
}

extension DashboardPresenter: DashboardModuleInterface {
    
}

extension DashboardPresenter: DashboardUIEvents {
    
    func didSelectConnection(at index: Int) {
        let ID = connections[index].ID
        interactor.setSelectedConnection(with: ID, completion: { (error: Error?) in
            
            if let error = error {
                self.didReceive(error: error)
                return
            }
            
            self.selectedConnectionIndex = index
            self.userInterface.show(selectionAt: index)
        })
    }
    
    func didChangeEnabledSwitch(to state: Bool) {
        interactor.setConnection(to: state)
    }
    
    func didTapAddConnection() {
        performSegue(withIdentifier: "Detail", sender: nil)
    }
    
    func didTapEditConnection(at index: Int) {
        let selectedIDForEditing = connections[index].ID
        performSegue(withIdentifier: "Detail", sender: selectedIDForEditing)
    }
    
}

extension DashboardPresenter: DashboardInteractorOutput {
    
    func connectionDidChange(to state: ConnectionState) {
        let isON = state == .connecting || state == .connected
        userInterface.show(connectionEnabled: isON)
        userInterface.show(status: state.toString())
    }
    
    func didReceive(error: Error) {
        let alertConrolller = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alertConrolller.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alertConrolller, animated: true, completion: nil)
    }
}

extension DashboardPresenter: EditorModuleDelegate {
    
    func didDelete(connectionID: String) {
        
        userInterface.setConnection(allowed: connections.count > 0)
        
        let isCurrent = isCurrentConnection(ID: connectionID)
        updateConnections()
        
        if !isCurrent {
            return
        }
        
        if (connections.count > 0) {
            didSelectConnection(at: selectedConnectionIndex!)
        } else {
            interactor.uninstallVPNConfiguration()
        }
    }
    
    func didEdit(connectionID editedConnectionID: String) {
        
        updateConnections()
        
        if isCurrentConnection(ID: editedConnectionID) {
            didSelectConnection(at: selectedConnectionIndex!)
        }
    }
    
    func didAdd() {
        let isFirst = selectedConnectionIndex == nil
        updateConnections()
        if isFirst {
            didSelectConnection(at: selectedConnectionIndex!)
        }
    }
    
    func isCurrentConnection(ID: String) -> Bool {
        guard let index = selectedConnectionIndex else {
            return false
        }
        
        let activeConnection = connections[index]
        return activeConnection.ID == ID
    }
}
