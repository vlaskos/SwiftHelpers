//
//  SelectedButton.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import UIKit

private struct ConstantsSuite {
    let alphaEnabled: CGFloat = 1
    let alphaDisabled: CGFloat = 0.5
}
private let constants = ConstantsSuite()

final class SelectedButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            self.alpha = isEnabled
                ? constants.alphaEnabled
                : constants.alphaDisabled
        }
    }
}

