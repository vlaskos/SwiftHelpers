//
//  UIViuew.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import UIKit

extension UIView {
    
    /// by default: radius = self.frame.size.height / 2
    func roundCorners(radius: CGFloat? = nil) {
        layer.cornerRadius = radius != nil ? radius! : frame.size.height / 2
        layer.masksToBounds = true
    }
    
    func getScreenHeight(excludeBottomInstet: Bool) -> CGFloat {
        let fullScreenHeight = UIScreen.main.bounds.height
        if #available(iOS 11.0, *), excludeBottomInstet == true {
            let bottomInset = self.safeAreaInsets.bottom
            return fullScreenHeight - bottomInset
        } else {
            return fullScreenHeight
        }
    }
    
    func setHiddenAnimated(hide: Bool, duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        guard self.isHidden != hide else { return }
        UIView.animate(withDuration: 0.3, delay: 0, options:
            UIView.AnimationOptions.curveEaseOut, animations: {
                
                if hide {
                    self.alpha = 0
                } else {
                    self.alpha = 0
                    self.isHidden = false
                    self.alpha = 1
                }
                
        }, completion: { _ in
            self.isHidden = hide
            completion?()
        })
    }
    
    //*****
    // https://stackoverflow.com/a/40720122
    //*****
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offset: CGSize, radius: CGFloat = 1, scale: Bool = true, cornerRadius: CGFloat = 0) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func makeSnapshot(rect: CGRect? = nil) -> UIImage {
           let renderer = UIGraphicsImageRenderer(bounds: rect ?? self.bounds)
           return renderer.image { (context) in
               self.layer.render(in: context.cgContext)
           }
       }
    
    //*****
    //https://stackoverflow.com/questions/24857986/load-a-uiview-from-nib-in-swift
    //*****
    
    @discardableResult   // 1
    func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            // xib not loaded, or its top view is of the wrong type
            return nil
        }
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layoutAttachAll()
        return contentView
    }
}

extension UIView {
    
    //******
    // https://stackoverflow.com/questions/41851892/nib-file-loaded-uiview-in-uitableviewcell-does-not-stretch
    //******
    
    /// attaches all sides of the receiver to its parent view
    func layoutAttachAll(margin : CGFloat = 0.0) {
        let view = superview
        layoutAttachTop(to: view, margin: margin)
        layoutAttachBottom(to: view, margin: margin)
        layoutAttachLeading(to: view, margin: margin)
        layoutAttachTrailing(to: view, margin: margin)
    }
    
    /// attaches the top of the current view to the given view's top if it's a superview of the current view, or to it's bottom if it's not (assuming this is then a sibling view).
    /// if view is not provided, the current view's super view is used
    @discardableResult
    func layoutAttachTop(to: UIView? = nil, margin : CGFloat = 0.0) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = view == superview
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: isSuperview ? .top : .bottom, multiplier: 1.0, constant: margin)
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    /// attaches the bottom of the current view to the given view
    @discardableResult
    func layoutAttachBottom(to: UIView? = nil, margin : CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: isSuperview ? .bottom : .top, multiplier: 1.0, constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    /// attaches the leading edge of the current view to the given view
    @discardableResult
    func layoutAttachLeading(to: UIView? = nil, margin : CGFloat = 0.0) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: isSuperview ? .leading : .trailing, multiplier: 1.0, constant: margin)
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    /// attaches the trailing edge of the current view to the given view
    @discardableResult
    func layoutAttachTrailing(to: UIView? = nil, margin : CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: isSuperview ? .trailing : .leading, multiplier: 1.0, constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        
        return constraint
    }
}
