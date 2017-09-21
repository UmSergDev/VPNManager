//
//  RuntimeHelper.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation

func swizzle(method1: Selector, method2: Selector, inClass: AnyClass)
{
    let originalMethod = class_getInstanceMethod(inClass, method1)
    let swizzledMethod = class_getInstanceMethod(inClass, method2)
    
    let didAddMethod = class_addMethod(inClass, method1, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
    
    if didAddMethod {
        class_replaceMethod(inClass, method2, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}
