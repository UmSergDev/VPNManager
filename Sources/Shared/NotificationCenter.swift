
//
//  NotificationCenter.swift
//  Ledger
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation

extension NotificationCenter {

    func addObserver(name: NSNotification.Name, closure: @escaping (Notification) -> Swift.Void) {
        self.addObserver(forName: name, object: nil, queue: nil, using: closure)
    }
}
