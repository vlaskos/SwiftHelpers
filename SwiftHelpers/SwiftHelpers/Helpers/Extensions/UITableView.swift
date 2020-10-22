//
//  UITableView.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import  UIKit

extension UITableView {
    
    public func reloadDataAndKeepOffset() {
        // stop scrolling
        setContentOffset(contentOffset, animated: false)
        
        let oldOffset = contentOffset
        reloadData()
        layoutIfNeeded()
        setContentOffset(oldOffset, animated: false)
    }
    
    public func scrollToBottom()  {
        let point = CGPoint(x: 0, y: self.contentSize.height + self.contentInset.bottom - self.frame.height)
        if point.y >= 0{
            self.setContentOffset(point, animated: true)
        }
    }
}

