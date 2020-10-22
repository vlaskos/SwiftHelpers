//
//  GradientSlider.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import Foundation
import UIKit

class GradientSlider: UISlider {
    
    var gradient: GradientView?
    var thumbTextLabel: UILabel = UILabel(frame: CGRect(x: 0, y: -15, width: 50, height: 15))
    var minLabel: UILabel = UILabel(frame: CGRect(x: 0, y: -5, width: 30, height: 15))
    var maxLabel: UILabel = UILabel(frame: CGRect(x: 0, y: -5, width: 30, height: 15))
    
    private var thumbFrame: CGRect {
        return thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        maxLabel.frame.origin.x = self.bounds.size.width - maxLabel.frame.width
        thumbTextLabel.frame.origin.x = thumbFrame.origin.x
        let sliderValue = NumberFormatter.decimal.string(from: NSNumber(value: self.value)) ?? String(format: "%.1f", self.value)
        thumbTextLabel.text = "\(sliderValue)°"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbTextLabel.layer.zPosition = layer.zPosition + 1
        thumbTextLabel.textColor = UIColor.red
        thumbTextLabel.font = UIFont.systemFont(ofSize: 10)
        addSubview(thumbTextLabel)
        
        let minLabelValue = NumberFormatter.decimal.string(from: 35.5) ?? "35,5"
        minLabel.text = "\(minLabelValue)°"
        minLabel.textColor = UIColor.blue
        minLabel.font = UIFont.systemFont(ofSize: 10)
        addSubview(minLabel)
        
        let maxLabelValue = NumberFormatter.decimal.string(from: 37.5) ?? "37,5"
        maxLabel.text = "\(maxLabelValue)°"
        maxLabel.textColor = UIColor.black
        maxLabel.font = UIFont.systemFont(ofSize: 10)
        maxLabel.textAlignment = .right
        addSubview(maxLabel)
    }
    
    override public func didMoveToSuperview() {
        addOffColorMask()
        super.didMoveToSuperview()
    }
    
    private func addOffColorMask() {
        
        self.maximumTrackTintColor = .clear
        self.minimumTrackTintColor = .clear
        
        let gradientView = GradientView()
        gradientView.topLeft = true
        gradientView.topRight = true
        gradientView.bottomLeft = true
        gradientView.bottomRight = true
        gradientView.cornerRadius = 2.5
        gradientView.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientView.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientView.firstColor = UIColor.red
        gradientView.secondColor = UIColor.black
        self.insertSubview(gradientView, at: 0)
//        gradientView.snp.makeConstraints({ (make) in
//            make.left.equalTo(self)
//            make.right.equalTo(self)
//            make.height.equalTo(5)
//            make.center.equalTo(self)
//        })
        gradientView.isHidden = self.isHidden
        self.gradient = gradientView
    }
    
}
