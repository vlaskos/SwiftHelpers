//
//  ToggleButton.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import UIKit

class ToggleButton: UIButton {
    
    var isOn: Bool = false {
        didSet {
            updateDisplay()
        }
    }
    var onImage: UIImage! = nil {
        didSet {
            updateDisplay()
        }
    }
    var offImage: UIImage! = nil {
        didSet {
            updateDisplay()
        }
    }
    
    func updateDisplay() {
        if isOn {
            if let onImage = onImage {
                setBackgroundImage(onImage, for: .normal)
            }
        } else {
            if let offImage = offImage {
                setBackgroundImage(offImage, for: .normal)
            }
        }
    }
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        isOn = !isOn
    }
}

