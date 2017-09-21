//
//  GradientView.swift
//  Ledger
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//


import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable
    var fromColor: UIColor = .black
    
    @IBInspectable
    var toColor: UIColor = .clear
    
    let gradientLayer = CAGradientLayer()
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        prepare()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        prepare()
//    }
    
    func prepare() {
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        gradientLayer.colors = [fromColor.cgColor, toColor.cgColor]
        gradientLayer.frame = bounds
    }
    
    override func prepareForInterfaceBuilder() {
        prepare()
    }
}
