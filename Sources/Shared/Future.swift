//
//  Future.swift
//  VPNManager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import Foundation

// untested!

class Future<T> {
    
    typealias CompletionClosure = (T)->()
    
    var resultHandled = false
    
    var result: T? {
        didSet {
            handleResult()
        }
    }
    
    var completion: CompletionClosure? {
        didSet {
            handleResult()
        }
    }
    
    func handleResult() {
        
        guard
            let completion = self.completion,
            let result = self.result,
            resultHandled == false
            else {
                return
        }
        
        resultHandled = true
        completion(result)        
    }
}
