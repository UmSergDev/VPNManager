//
//  ConnectionState.swift
//  VPNManager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation

enum ConnectionState: Int {
    case connecting
    case connected
    case disconnecting
    case disconnected
}

extension ConnectionState {
    func toString() -> String {
        switch self {
        case .connected:
            return "Connected"
        case .connecting:
            return "Connecting"
        case .disconnecting:
            return "Disconnecting"
        case .disconnected:
            return "Disconnected"
        }
    }
}
