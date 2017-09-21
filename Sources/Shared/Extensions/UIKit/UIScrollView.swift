//
//  UIScrollView.swift
//  Ledger
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    var absoluteContentOffset: CGPoint {
        get {
            // кейс contentInset.left > 0 не проверен
            return contentOffset.applying(CGAffineTransform(translationX: contentInset.left, y: contentInset.top))
        }
        
        set {
             contentOffset.applying(CGAffineTransform(translationX: -contentInset.left, y: -contentInset.top))
        }
    }
    
}
