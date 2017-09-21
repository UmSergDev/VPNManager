//
//  ModuleConfiguration.swift
//  Ledger
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

public protocol ModuleConfiguration {
    func configure(controller: UIViewController, with parameter: AnyObject?) -> Bool
}
