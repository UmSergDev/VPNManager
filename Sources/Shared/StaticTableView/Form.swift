//
//  StaticTableViewManager.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

protocol StaticSection: class {
    var rows: [CellHandler] { get } // required
    var headerText: String { get }
    var footerText: String { get }
}

protocol CellHandler {
    var tableCell: UITableViewCell { get } // required
    func update()
    func handleSelection()
}

class Form: NSObject {
    var sections = [StaticSection]()
}

extension Form: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].rows[indexPath.row].tableCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].headerText
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footerText
    }
}

extension CellHandler {
    func update() {
        
    }
    
    func handleSelection() {
        
    }
}

extension StaticSection {
    var headerText: String {
        get {
            return ""
        }
    }
    
    var footerText: String {
        get {
            return ""
        }
    }
}
