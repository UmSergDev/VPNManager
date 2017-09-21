//
//  ConnectionListItem.swift
//  VPNManager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation

class ConnectionListItem: NSObject {
    let ID: String
    let title: String
    let selected: Bool
    
    public init(ID: String, title: String, selected: Bool) {
        self.ID = ID
        self.title = title
        self.selected = selected
    }
}
