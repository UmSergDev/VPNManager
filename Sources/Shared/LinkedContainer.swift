//
//  LinkedContainer.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation

class LinkedContainer<T> {
    let object: T
    var nextContainer: LinkedContainer<T>?
    public init(with object: T) {
        self.object = object
    }
}
