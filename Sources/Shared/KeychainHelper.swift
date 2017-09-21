//
//  KeychainPasswordManager.swift
//  VPN Manager
//
//  Created by Sergey Umarov on 24.11.16.
//  Copyright © 2016 Sergey Umarov. All rights reserved.
//

import UIKit

class KeychainHelper: NSObject {

    let key: String
    let serviceName = Bundle.init(for: KeychainHelper.self).bundleIdentifier!
    let query: [String: AnyObject]
    
    public init(key: String) {
        self.key = key
        let identifier = key.data(using: .utf8)!
        
        query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: identifier as AnyObject,
            kSecAttrService as String: serviceName as AnyObject]
    }
    
    func getValue() -> String? {
        return nil // not implemented
    }
    
    func getReference() -> Data? {
        var result: AnyObject?
        var query = self.query
        query[kSecReturnPersistentRef as String] = true as AnyObject
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if let data = result as? Data, status == noErr {
            return data
        }

        return nil
    }
    
    func hasValue() -> Bool {
        return getReference() != nil
    }
    
    func set(value: String) {
        var result: AnyObject?
        var query = self.query
        
        let key = kSecValueData as String
        let value = value.data(using: .utf8) as AnyObject
        
        if hasValue() {
            let dataToUpdate = [key: value]
            print(SecItemUpdate(query as CFDictionary, dataToUpdate as CFDictionary))
        }
        else {
            query[key] = value
            print(SecItemAdd(query as CFDictionary, &result))
        }
    }
    
    func delete() {
        SecItemDelete(query as CFDictionary)
    }
}
