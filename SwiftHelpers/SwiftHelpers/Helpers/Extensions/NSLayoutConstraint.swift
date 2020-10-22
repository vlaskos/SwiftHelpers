//
//  NSLayoutConstraint.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    
    func animate(on value: CGFloat, duration: TimeInterval = 0.3, layoutView view: UIView, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.constant = value
            view.layoutIfNeeded()
        }, completion: { success in
            completion?(success)
        })
    }
}

