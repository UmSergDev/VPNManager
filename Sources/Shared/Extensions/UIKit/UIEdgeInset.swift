//
//  UIEdgeInset.swift
//  Ledger
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

extension UIEdgeInsets {

    public init(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        self = UIEdgeInsetsMake(top, left, bottom, right)
    }

}
