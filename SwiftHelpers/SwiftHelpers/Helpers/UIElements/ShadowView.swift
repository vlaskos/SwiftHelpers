//
//  ShadowView.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import Foundation
import UIKit

class ShadowView: UIView {
    override class var layerClass: Swift.AnyClass {
        return CAShapeLayer.self
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
    
    @IBInspectable var shadowOffset: Int = 5 {
        didSet {
            updateView()
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 5 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.8 {
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
    
    private var cornerMask: UIRectCorner? {
        didSet {
            updateView()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let shadowLayer = layer as? CAShapeLayer else { return }
        if let a = shadowLayer.animation(forKey: "bounds.size") {
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                self.updateView()
            }
            let shadowPathAnim = CABasicAnimation(keyPath: "shadowPath")
            shadowPathAnim.duration = a.duration
            shadowPathAnim.timingFunction = a.timingFunction
            shadowPathAnim.toValue = shadowPath(for: bounds, cornerRadius: cornerRadius)
            layer.add(shadowPathAnim, forKey: "shadowPath")
            CATransaction.commit()
        } else {
            updateView()
        }
    }

}

private extension ShadowView {

    func setupView() {
        guard let shadowLayer = layer as? CAShapeLayer else { return }
        shadowLayer.masksToBounds = false
        shadowLayer.shadowColor = UIColor.gray.cgColor
        shadowLayer.shadowOpacity = 0.8
        shadowLayer.shadowOffset = CGSize(width: 0, height: 5)
        shadowLayer.shouldRasterize = true
        shadowLayer.rasterizationScale = UIScreen.main.scale
        updateView()
    }
    
    func updateCornerMask() {
        cornerMask = UIRectCorner(
            TL: topLeft,
            TR: topRight,
            BL: bottomLeft,
            BR: bottomRight)
    }

    func updateView() {
        guard let shadowLayer = layer as? CAShapeLayer else { return }
        shadowLayer.shadowOffset = CGSize(width: 0, height: shadowOffset)
        shadowLayer.shadowRadius = self.shadowRadius
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.cornerRadius = cornerRadius
        shadowLayer.shadowPath = shadowPath(for: bounds, cornerRadius: cornerRadius)
    }

    func shadowPath(for rect: CGRect, cornerRadius: CGFloat) -> CGPath {
        return UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: cornerMask ?? [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        ).cgPath
    }
}

extension UIRectCorner {
    init(TL: Bool = false, TR: Bool = false, BL: Bool = false, BR: Bool = false) {
        var value: UInt = 0
        if TL { value += 1 }
        if TR { value += 2 }
        if BL { value += 4 }
        if BR { value += 8 }
        
        self.init(rawValue: value)
    }
}
