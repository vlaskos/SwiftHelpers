//
//  UILabel.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import UIKit

extension UILabel {
    func autoShrinkFont() -> UIFont {
        guard self.numberOfLines == 1,
              let text = self.text, !text.isEmpty,
              self.minimumScaleFactor != 0.0 else {
            return self.font!
        }
        
        let width = self.bounds.width
        var textWidth = (text as NSString).size(withAttributes: [.font: self.font!]).width
    
        guard textWidth > width else {
            return self.font!
        }
    
        var font = self.font.withSize(self.font.pointSize - 1)
        let minFontSize = self.font.pointSize * self.minimumScaleFactor
    
        while font.pointSize >= minFontSize {
            textWidth = (text as NSString).size(withAttributes: [.font: font]).width
            if width > textWidth {
                return font
            }
            font = self.font.withSize(font.pointSize - 1)
        }
        
        return self.font!
    }
}
