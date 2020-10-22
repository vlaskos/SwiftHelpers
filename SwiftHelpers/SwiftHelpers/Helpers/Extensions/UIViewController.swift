//
//  UIViewController.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func storyboardInstance<T: UIViewController>() -> T {
        let storyboard = UIStoryboard(name: "", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
        return controller
    }
    
    static func storyboardInstance<T: UIViewController>(storyboardName: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
        return controller
    }
}
