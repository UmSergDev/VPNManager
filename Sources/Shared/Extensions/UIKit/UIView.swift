//
//  UIView.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

struct Edges: OptionSet {
    let rawValue: Int
    
    static let left     = Edges(rawValue: 1 << 0)
    static let right    = Edges(rawValue: 1 << 1)
    static let top      = Edges(rawValue: 1 << 2)
    static let bottom   = Edges(rawValue: 1 << 3)
    
    static let all: Edges = [.left, .right, .top, .bottom]
}

extension UIView {
    
    func wrapped(with insets: UIEdgeInsets) -> UIView {
        let wrapper = UIView()
        wrapper.addSubview(self)
        
        var contentSize = self.bounds.size
        contentSize.width += insets.left + insets.right
        contentSize.height += insets.top + insets.bottom
        
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.frame = CGRect(origin: origin, size: contentSize)
        
        let wrapperSize = CGSize(width: contentSize.width + insets.right,
                                 height: contentSize.height + insets.bottom)
        wrapper.bounds = CGRect(origin: .zero, size: wrapperSize)
        
        return wrapper
    }
    
    @discardableResult
    func pin(edges: Edges = Edges.all, to view: UIView? = nil, with insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        guard let view = view ?? superview else {
            return []
        }
        
        var constraints = [NSLayoutConstraint]()
     
        if edges.contains(.top) {
            constraints.append(topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top))
        }
        
        if edges.contains(.bottom) {
            constraints.append(bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom))
        }
        
        if edges.contains(.left) {
            constraints.append(leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left))
        }
        
        if edges.contains(.right) {
            constraints.append(rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right))
        }
        
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
}

extension UIViewAnimationCurve {
    func toOptions() -> UIViewAnimationOptions {
        // Не работает?
        return UIViewAnimationOptions(rawValue: UInt(rawValue << 16))
    }
}
