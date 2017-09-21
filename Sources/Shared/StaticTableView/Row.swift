//
//  RowDescription.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

protocol Row: class, CellHandler {
    
    associatedtype CellType: UITableViewCell
    
    var cell: CellType? { set get }
    
    func initiate(cell: CellType) // optional
    func fill(cell: CellType)
    func update()
    
    func cellStyle() -> UITableViewCellStyle // optional, right-detail style by default
}

extension Row {
    
    var tableCell: UITableViewCell {
        get {
            if let cell = self.cell {
                return cell
            }
            
            let cell = CellType(style: cellStyle(), reuseIdentifier: nil)
            initiate(cell: cell)
            self.cell = cell
            return cell
        }
    }
    
    func initiate(cell: CellType) {
        fill(cell: cell)
    }
    
    func cellStyle() -> UITableViewCellStyle {
        return .value1
    }
    
    func update() {
        cell = nil
    }
}
