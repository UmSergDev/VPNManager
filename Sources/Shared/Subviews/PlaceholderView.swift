//
//  PlaceholderView.swift
//  Ledger
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

class PlaceholderView: UIView {
    
    var contentSize = CGSize(width: UIViewNoIntrinsicMetric, height: UIViewNoIntrinsicMetric) {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    let label = UILabel(text: "Placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    func prepare() {
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        layoutIfNeeded()
    }
}
