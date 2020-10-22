//
//  UIScrollView.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    
    struct IntNumber {
        static var _myComputedProperty: Int = 0
    }
    
    var lastVelocityYSign: Int {
        get {
            return IntNumber._myComputedProperty
        }
        set(newValue) {
            IntNumber._myComputedProperty = newValue
        }
    }
    
    func isLoadMore() -> Bool {
        
        let currentOffset = self.contentOffset.y
        let maximumOffset = self.contentSize.height - self.frame.size.height
        let deltaOffset =  maximumOffset - currentOffset
        
        if deltaOffset < 0 && self.contentSize.height > self.frame.size.height {
            return true
        }
        
        return false
    }
    
    func isUp() -> Bool  {
        
        let currentVelocityY =  self.panGestureRecognizer.velocity(in: self.superview).y
        
        let currentVelocityYSign = Int(currentVelocityY).signum()
        
        if currentVelocityYSign != lastVelocityYSign &&
            currentVelocityYSign != 0 {
            lastVelocityYSign = currentVelocityYSign
        }
        
        if lastVelocityYSign < 0 {
            return false
        } else if lastVelocityYSign > 0 {
           return true
        }

        return false
    }
}
