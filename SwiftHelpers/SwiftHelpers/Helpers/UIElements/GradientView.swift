//
//  GradientView.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    override class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    @IBInspectable var firstColor: UIColor = UIColor.magenta {
        didSet {
            updateView()
        }
    }
    @IBInspectable var secondColor: UIColor = UIColor.blue {
        didSet {
            updateView()
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var topLeft: Bool = false {
        didSet {
            updateCornerMask()
        }
    }
    
    @IBInspectable var topRight: Bool = false {
        didSet {
            updateCornerMask()
        }
    }
    
    @IBInspectable var bottomLeft: Bool = false {
        didSet {
            updateCornerMask()
        }
    }
    
    @IBInspectable var bottomRight: Bool = false {
        didSet {
            updateCornerMask()
        }
    }
    
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 1, y: 1) {
        didSet {
            updateView()
        }
    }
    
    private var cornerMask: CACornerMask? {
        didSet {
            updateView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupView()
    }

}

private extension GradientView {
    func setupView() {
        updateView()
    }

    func updateView() {
        guard let layer = self.layer as? CAGradientLayer else { return }
        layer.colors = [self.firstColor.cgColor, self.secondColor.cgColor]
        layer.startPoint = startPoint
        layer.endPoint = endPoint
        layer.type = .axial
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = cornerRadius > 0
        layer.maskedCorners = cornerMask ?? [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        setNeedsDisplay()
    }
    
    func updateCornerMask() {
        cornerMask = CACornerMask(
            TL: topLeft,
            TR: topRight,
            BL: bottomLeft,
            BR: bottomRight)
    }
}

extension CACornerMask {
    init(TL: Bool = false, TR: Bool = false, BL: Bool = false, BR: Bool = false) {
        var value: UInt = 0
        if TL { value += 1 }
        if TR { value += 2 }
        if BL { value += 4 }
        if BR { value += 8 }
        
        self.init(rawValue: value)
    }
}

