//
//  DashboardViewAdapter.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

class DashboardViewAdapter: NSObject, DashboardUIInterface {
        
//    internal let statusSwitchControl = UISwitch()
    internal var statusLabel: UILabel?
    
    public weak var eventHandler: DashboardUIEvents!
    private let tableView: UITableView
    
    let form = DashboardForm()
    
    init(with view: UITableView) {
        self.tableView = view
        super.init()
        view.delegate = self
        view.dataSource = form
        setupActions()
    }
    
    func setupActions() {
        form.connectionSwitch.addTarget(self, action: #selector(DashboardViewAdapter.didChangeStatusSwitch), for: .valueChanged)
        
        form.addConnectionButton.selectionClosure = {
            self.eventHandler.didTapAddConnection()
        }
    }
        
    // MARK: DashboardUIInterface
 
    func show(connectionEnabled: Bool) {
        form.connectionControlStatus = connectionEnabled ? .on : .off
    }
    
    func show(status: String) {
        form.statusValue = status
        tableView.reloadData()
    }
    
    func show(connections: [UIConnection]) {
        form.connections = connections
        tableView.reloadData()
    }
    
    func setConnection(allowed: Bool) {
        form.connectionControlStatus = allowed ? .off : .disabled
    }
    
    func show(selectionAt index: Int) {
        
        guard form.selectionIndex != index else {
            return
        }
        
        form.selectionIndex = index
        tableView.reloadData()
    }
    
    // Action handlers 
    
    func didChangeStatusSwitch() {
        self.eventHandler.didChangeEnabledSwitch(to: form.connectionSwitch.isOn)
    }
    
    func handleConnectionTap(at index: Int) {
        guard (form.connections.count > 0) else {
            return
        }
        self.eventHandler.didSelectConnection(at: index)
    }
}

extension DashboardViewAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        form.sections[indexPath.section].rows[indexPath.row].handleSelection()
        
        let section = form.sections[indexPath.section]
        guard form.connections.count > 0 && section === form.connectionsSection else {
            return
        }
        
        eventHandler.didSelectConnection(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        eventHandler.didTapEditConnection(at: indexPath.row)
    }
    
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection sectionNumber: Int) -> Int {
//        
//        if let section = Section(rawValue: sectionNumber), section == .connection && connections.count > 0 {
//            return connections.count
//        }
//        
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let identifier = cellIdentifier(for: indexPath)
//        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
//        configure(cell: cell, with: indexPath)
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//        guard let section = Section(rawValue: indexPath.section) else {
//            return
//        }
//        
//        switch section {
//        case .connection:
//            handleConnectionTap(at: indexPath.item)
//        case .create:
//            eventHandler.didTapAddConnection()
//        default:
//            break
//        }
//    }


    
    // MARK: UITableView helpers
    
//    func configure(cell: UITableViewCell, with indexPath: IndexPath) {
//        
//        let identifier = sections[indexPath.section]
//        
//        switch identifier {
//        case .status: configure(statusCell: cell)
//        case .connection: configure(connectionCell: cell, with: indexPath)
//        default: break
//        }
//    }
    
//    func cellIdentifier(for indexPath: IndexPath) -> String {
//        let section = sections[indexPath.section]
//        
//        if section == .connection && connections.count == 0 {
//            return blankCellIdentifier
//        }
//        return section.defaultCellIdentifier()
//    }
//    
//    func configure(statusCell: UITableViewCell) {
    
//        let container = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
//        container.addSubview(statusSwitchControl)
//        
//        statusSwitchControl.snp.makeConstraints { (make) in
//            make.centerY.equalTo(container)
//            make.right.equalTo(container)
//        }
        
//        statusCell.accessoryView = container
//        statusLabel = statusCell.detailTextLabel
//        statusLabel?.transform = CGAffineTransform(translationX: -8, y: 0)
//    }

//    func configure(connectionCell: UITableViewCell, with indexPath: IndexPath) {
//        
//        guard (connections.count > 0) else {
//            return
//        }
//        
//        let connection = connections[indexPath.item]
//        let selected = selectedConnectionIndex == indexPath.item
//        connectionCell.textLabel?.text = connection.title
//        let image = selected ? checkmarkImage : noCheckmarkImage
//        connectionCell.imageView?.image = image
//    }
//}

//extension DashboardViewAdapter.Section {
//    func defaultCellIdentifier() -> String {
//        switch self {
//        case .status:
//            return "Status"
//        case .connection:
//            return "Connection"
//        case .create:
//            return "Create"
//        }
//    }
    
}
