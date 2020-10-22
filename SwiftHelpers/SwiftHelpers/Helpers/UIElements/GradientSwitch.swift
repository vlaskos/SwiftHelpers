//
//  GradientSwitch.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import UIKit

class GradientSwitch: UISwitch {
    
    var gradient: GradientView?

    override public func didMoveToSuperview() {
        addOffColorMask()
        super.didMoveToSuperview()
    }
    
    private func addOffColorMask() {
        
        self.onTintColor = .clear
        let gradientView = GradientView()
        gradientView.topLeft = true
        gradientView.topRight = true
        gradientView.bottomLeft = true
        gradientView.bottomRight = true
        gradientView.cornerRadius = self.bounds.height / 2
        gradientView.firstColor = UIColor.red
        gradientView.secondColor = UIColor.black
        self.insertSubview(gradientView, at: 0)
//        gradientView.snp.makeConstraints({ (make) in
//            make.left.equalTo(self)
//            make.right.equalTo(self).offset(2)
//            make.top.equalTo(self)
//            make.bottom.equalTo(self)
//        })
        gradientView.isHidden = self.isHidden
        gradientView.isHidden = !isOn
        self.gradient = gradientView
        self.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
    }
    
    override var isOn: Bool {
        didSet {
            self.gradient?.isHidden = !isOn
        }
    }
    
    @objc
    func switchValueDidChange(_ sender: UISwitch) {
        self.gradient?.setHiddenAnimated(hide: !sender.isOn, duration: 0.1)
    }
}

