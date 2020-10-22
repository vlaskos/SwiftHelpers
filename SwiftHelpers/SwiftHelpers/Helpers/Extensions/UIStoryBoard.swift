//
//  UIStoryBoard.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    func instantiateVC<T: UIViewController>() -> T? {
        if let name = String(describing: T.self).components(separatedBy: ".").last {
            return instantiateViewController(withIdentifier: name) as? T
        }
        return nil
    }
    
}
