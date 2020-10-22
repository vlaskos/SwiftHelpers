//
//  GradientProgressView.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import UIKit

final class ProgressView: UIView {
    
    private let progressView: GradientView = makeRoundedGradientView()
    private let backgroundView: GradientView = makeRoundedGradientView(alpha: 0.2)
    private let maskShape = CAShapeLayer()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.progressView.frame = .init(origin: .zero, size: bounds.size)
        self.backgroundView.frame = .init(origin: .zero, size: bounds.size)
        
        let cornerRadius = bounds.height / 2.0
        
        self.backgroundView.cornerRadius = cornerRadius
        self.progressView.cornerRadius = cornerRadius
        
        self.maskShape.path = UIBezierPath(
            roundedRect: .init(
                origin: self.backgroundView.frame.origin,
                size: .init(
                    width: 0,
                    height: self.backgroundView.bounds.height)),
            cornerRadius: cornerRadius).cgPath
    }
}

private extension ProgressView {
    func setup() {
        addSubview(backgroundView)
        addSubview(progressView)
    
        progressView.layer.mask = maskShape
    }
}

extension ProgressView {
    
    /// - Values: 0...100
    
    func setProgress(_ progress: CGFloat, _ completion: @escaping () -> Void) {
        let value = min(abs(progress), CGFloat(100))
        let progressWidth = self.bounds.width * value / 100.0
        
        let fromPath = self.maskShape.path
        let toPath = UIBezierPath(
            roundedRect: .init(
                origin: self.backgroundView.frame.origin,
                size: .init(
                    width: progressWidth,
                    height: self.backgroundView.bounds.height)),
            cornerRadius: self.backgroundView.cornerRadius).cgPath
    
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        self.maskShape.path = toPath
        CATransaction.commit()
    
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion()
        }
    
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = fromPath
        animation.toValue = toPath
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        self.maskShape.add(animation, forKey: nil)
    
        CATransaction.commit()
    }
}

private func makeRoundedGradientView(alpha: CGFloat = 1) -> GradientView {
    let view = GradientView()
    view.topRight = true
    view.topLeft = true
    view.bottomLeft = true
    view.bottomRight = true
    view.firstColor = UIColor.red
    view.secondColor = UIColor.blue
    view.alpha = alpha
    return view
}

