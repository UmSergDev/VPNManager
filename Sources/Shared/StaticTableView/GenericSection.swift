
//
//  GenericSection.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation

class GenericSection: StaticSection {
    var headerText: String
    var footerText: String
    var rows: [CellHandler]
    
    public init(rows: [CellHandler] = [], headerText: String = "", footerText: String = "") {
        self.headerText = headerText
        self.footerText = footerText
        self.rows = rows
    }
}
