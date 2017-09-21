//
//  DashboardForm.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

fileprivate let CheckmarkImage = #imageLiteral(resourceName: "checkmark")
fileprivate let NoCheckmarkImage = #imageLiteral(resourceName: "no-checkmark")

class DashboardForm: Form {
    
    // Input data
    
    enum ConnectionControlStatus: Int {
        case on
        case off
        case disabled
    }
    
    var connectionControlStatus = ConnectionControlStatus.disabled {
        didSet {
            connectionSwitch.isOn = connectionControlStatus == .on
            connectionSwitch.isEnabled = connectionControlStatus != .disabled
        }
    }
    
    var statusValue = String() {
        didSet {
            status.detailText = statusValue
            status.update()
        }
    }
    
    var connections = [UIConnection]() {
        didSet {
            updateConnections()
        }
    }
    
    var selectionIndex: Int? {
        didSet {
            updateConnections()
        }
    }
    
    // Sections
    
    let mainSection = GenericSection()
    let connectionsSection = GenericSection()
    let addConnectionSection = GenericSection()
    
    // Cells and their details
    
    let connectionSwitch = UISwitch()
    let status: GenericRow = GenericRow(labelText: Dashboard.localizedString(for: "status-title"))

    let noConnectionsRow = GenericRow(labelText: Dashboard.localizedString(for: "no-connections"))
    
    let addConnectionButton = GenericRow {
        $0.textLabel?.text = Dashboard.localizedString(for: "add-connection")
        $0.textLabel?.textColor = $0.tintColor ?? .blue
    }
    
    // Init
    
    override init() {
        
        mainSection.rows = [status]
        addConnectionSection.rows = [addConnectionButton]
        
        noConnectionsRow.configururationClosure = { cell in
            cell.textLabel?.textColor = .gray
        }
        
        super.init()
        
        sections = [
            mainSection,
            connectionsSection,
            addConnectionSection
        ]
        
        status.configururationClosure = { (cell) in
            cell.textLabel?.text = Dashboard.localizedString(for: "status-title")
            cell.accessoryView = self.connectionSwitch.wrapped(with: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0))
            cell.detailTextLabel?.text = self.statusValue
        }
    }
    
    func updateConnections() {
        
        if connections.count == 0 {
            connectionsSection.rows = [noConnectionsRow]
            return
        }
        
        connectionsSection.rows = {
            var handlers = [CellHandler]()
            for index in self.connections.indices {
                
                let connection = self.connections[index]
                handlers.append(GenericRow { (cell) in
                    cell.accessoryType = .detailDisclosureButton
                    cell.textLabel?.text = connection.title
                    let isSelected = index == self.selectionIndex
                    cell.imageView?.image = isSelected ? CheckmarkImage : NoCheckmarkImage
                })
            }
            return handlers
        }()
    }
}
