//
//  UIAllertController.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    // Notification
    class func displayNotification(parmTitle: String, parmMessage: String) {
        let alert = UIAlertController(title: parmTitle, message: parmMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        displayAlert(parmAlert: alert)
    }

    
    // Display Alert
    class func displayAlert(parmAlert: UIAlertController) {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.rootViewController?.present(parmAlert, animated: true, completion: nil)
    }
    
    
    // Function Wrapper
    class func funcHandler(f:(()->())?) {
        f?()
    }
    
    static func showActionsheet(viewController: UIViewController, title: String?, message: String?, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for (index, (title, style)) in actions.enumerated() {
            let alertAction = UIAlertAction(title: title, style: style) { (_) in
                completion(index)
            }
            alertViewController.addAction(alertAction)
        }
        viewController.present(alertViewController, animated: true, completion: nil)
    }
}
