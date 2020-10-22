//
//  UIColor.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /**
     Create a darker color
     */
    func darker(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjustBrightness(by: -abs(percentage))
    }
    
    /**
     Try to increase brightness or decrease saturation
     */
    func adjustBrightness(by percentage: CGFloat = 30.0) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            if b < 1.0 {
                let newB: CGFloat = max(min(b + (percentage / 100.0) * b, 1.0), 0.0)
                return UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
            } else {
                let newS: CGFloat = min(max(s - (percentage / 100.0) * s, 0.0), 1.0)
                return UIColor(hue: h, saturation: newS, brightness: b, alpha: a)
            }
        }
        return self
    }
    
}
extension UIColor {
    /// percentage from 0 to 1
    static func getGradientColor(from: UIColor, to: UIColor, percentage: CGFloat) -> UIColor? {
        precondition(percentage >= 0 && percentage <= 1)
        let fromRgbColours = from.cgColor.components
        let toRgbColours = to.cgColor.components
        
        guard let fromColours = fromRgbColours, let toColours = toRgbColours else {
            return nil
        }
        return UIColor(red: fromColours[0] + CGFloat(toColours[0] - fromColours[0]) * percentage,
                       green: fromColours[1] + CGFloat(toColours[1] - fromColours[1]) * percentage,
                       blue: fromColours[2] + CGFloat(toColours[2] - fromColours[2]) * percentage,
                       alpha: 1)
    }
    
    /// format is 0..255 (alpha is 1.0 by default)
    class func fromRGBIntegers(red: Int, green: Int, blue: Int) -> UIColor {
        return UIColor(red: CGFloat(Float(red) / 255.0),
                       green: CGFloat(Float(green) / 255.0),
                       blue: CGFloat(Float(blue) / 255.0),
                       alpha: CGFloat(1.0))
    }
    
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { context in
            self.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }
}
