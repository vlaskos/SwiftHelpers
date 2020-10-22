//
//  PasscodeUtil.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import LocalAuthentication
import UIKit

public final class PasscodeUtils {
    
    @available(iOS 8.0, *)
    static func devicePasscodeEnabledUsingKeychain() -> Bool {
        let query: [String:Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : UUID().uuidString,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
            kSecValueData as String: "HelloWorld".data(using: String.Encoding.utf8)!,
            kSecReturnAttributes as String : kCFBooleanTrue
        ]
        
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        
        if status == errSecItemNotFound {
            let createStatus = SecItemAdd(query as CFDictionary, nil)
            guard createStatus == errSecSuccess else { return false }
            status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        }
        
        guard status == errSecSuccess else { return false }
        
        return true
    }
    
    static func devicePasscodeEnabled() -> Bool {
        if #available(iOS 9.0, *) {
            return LAContext().canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        } else {
            return PasscodeUtils.devicePasscodeEnabledUsingKeychain()
        }
    }
    
    @available(iOS 8.0, *)
    static func deviceBiometricsEnabled() -> Bool {
        return LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    @available(iOS 8.0, *)
    static func secureEnabled() -> Bool {
        if PasscodeUtils.deviceBiometricsEnabled() == true || PasscodeUtils.devicePasscodeEnabled() == true {
            return true
        }
        return false
    }
}

