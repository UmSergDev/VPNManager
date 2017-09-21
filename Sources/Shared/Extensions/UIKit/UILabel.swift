//
//  UILabel.swift
//  Ledger
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

public extension UILabel {
    
    convenience init(text: String) {
        self.init(frame: .zero)
        self.text = text
        self.sizeToFit()
    }
    
}
