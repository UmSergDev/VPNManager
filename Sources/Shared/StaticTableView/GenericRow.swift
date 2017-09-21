//
//  LabelStaticRow.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

class GenericRow: Row {
    
    
    typealias ConfigurationClosure = (UITableViewCell)->()
    
    typealias CellType = UITableViewCell
    
    var cell: CellType?
    var style = UITableViewCellStyle.value1

    var selectionClosure: (()->())?
    var configururationClosure: ConfigurationClosure?
    
    var labelText: String?
    var detailText: String?
    
    init(with configurationClosure: @escaping ConfigurationClosure) {
        self.configururationClosure = configurationClosure
    }
    
    init(labelText: String, detailText: String = "") {
        self.labelText = labelText
        self.detailText = detailText
    }
    
    internal func fill(cell: CellType) {
        cell.textLabel?.text = labelText
        cell.detailTextLabel?.text = detailText
        configururationClosure?(cell)
    }
    
    func handleSelection() {
        selectionClosure?()
    }
}
