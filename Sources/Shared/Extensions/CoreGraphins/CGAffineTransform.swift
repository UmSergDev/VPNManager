//
//  CGAffineTransform.swift
//  Ledger
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

extension CGAffineTransform {
    init(translationPoint: CGPoint) {
        // инит не проверен
        self.init(scaleX: translationPoint.x, y: translationPoint.y)
    }
}
