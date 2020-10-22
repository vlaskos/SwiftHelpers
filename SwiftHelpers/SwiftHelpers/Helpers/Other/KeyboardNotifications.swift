//
//  KeyboardNotifications.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import UIKit
import CoreGraphics

class KeyboardNotifications {
    
    fileprivate var _isEnabled: Bool
    fileprivate var notifications: [KeyboardNotificationsType]
    fileprivate weak var delegate: KeyboardNotificationsDelegate?
    
    init(notifications: [KeyboardNotificationsType], delegate: KeyboardNotificationsDelegate) {
        _isEnabled = false
        self.notifications = notifications
        self.delegate = delegate
    }
    
    deinit {
        if isEnabled {
            isEnabled = false
        }
    }
}

// MARK: - enums

extension KeyboardNotifications {
    
    enum KeyboardNotificationsType {
        case willShow, willHide, didShow, didHide, didChangeFrame, willChangeFrame
        
        var selector: Selector {
            switch self {
                
            case .willShow:
                return #selector(KeyboardNotifications.keyboardWillShow(notification:))
                
            case .willHide:
                return #selector(KeyboardNotifications.keyboardWillHide(notification:))
                
            case .didShow:
                return #selector(KeyboardNotifications.keyboardDidShow(notification:))
                
            case .didHide:
                return #selector(KeyboardNotifications.keyboardDidHide(notification:))
                
            case .didChangeFrame:
                return #selector(KeyboardNotifications.keyboardDidChangeFrame(notification:))
                
            case .willChangeFrame:
                return #selector(KeyboardNotifications.keyboardWillChangeFrame(notification:))
            }
        }
        
        var notificationName: NSNotification.Name {
            switch self {
                
            case .willShow:
                return UIResponder.keyboardWillShowNotification
                
            case .willHide:
                return UIResponder.keyboardWillHideNotification
                
            case .didShow:
                return UIResponder.keyboardDidShowNotification
                
            case .didHide:
                return UIResponder.keyboardDidHideNotification
                
            case .didChangeFrame:
                return UIResponder.keyboardDidChangeFrameNotification
                
            case .willChangeFrame:
                return UIResponder.keyboardWillChangeFrameNotification
            }
        }
    }
}

// MARK: - isEnabled

extension KeyboardNotifications {
    
    private func addObserver(type: KeyboardNotificationsType) {
        NotificationCenter.default.addObserver(self, selector: type.selector, name: type.notificationName, object: nil)
    }
    
    var isEnabled: Bool {
        set {
            if newValue {
                
                for notificaton in notifications {
                    addObserver(type: notificaton)
                }
            } else {
                NotificationCenter.default.removeObserver(self)
            }
            _isEnabled = newValue
        }
        
        get {
            return _isEnabled
        }
    }
    
}

// MARK: - Notification functions

extension KeyboardNotifications {
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        delegate?.keyboardWillShow?(notification: notification)
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        delegate?.keyboardWillHide?(notification: notification)
    }
    
    @objc
    func keyboardDidShow(notification: NSNotification) {
        delegate?.keyboardDidShow?(notification: notification)
    }
    
    @objc
    func keyboardDidHide(notification: NSNotification) {
        delegate?.keyboardDidHide?(notification: notification)
    }
    
    @objc
    func keyboardWillChangeFrame(notification: NSNotification) {
        delegate?.keyboardWillChangeFrame?(notification: notification)
    }
    
    @objc
    func keyboardDidChangeFrame(notification: NSNotification) {
        delegate?.keyboardDidChangeFrame?(notification: notification)
    }
}

@objc
protocol KeyboardNotificationsDelegate {
    @objc
    optional func keyboardWillShow(notification: NSNotification)
    @objc
    optional func keyboardWillHide(notification: NSNotification)
    @objc
    optional func keyboardDidShow(notification: NSNotification)
    @objc
    optional func keyboardDidHide(notification: NSNotification)
    @objc
    optional func keyboardWillChangeFrame(notification: NSNotification)
    @objc
    optional func keyboardDidChangeFrame(notification: NSNotification)
}

/////////

struct KeyboardPayload {
    let beginFrame: CGRect
    let endFrame: CGRect
    let curve: UIView.AnimationCurve
    let duration: TimeInterval
    let isLocal: Bool
}

extension KeyboardPayload {
    init(note: NSNotification) {
        let userInfo = note.userInfo
        beginFrame = userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
        endFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        curve = UIView.AnimationCurve(rawValue: userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! Int)!
        duration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        isLocal = userInfo?[UIResponder.keyboardIsLocalUserInfoKey] as! Bool
    }
}

