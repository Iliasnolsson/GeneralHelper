//
//  UIEdgeInsetExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-18.
//

import UIKit

public extension UIEdgeInsets {
    
    init(_ inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    init(x: HorizontalInset, y: VerticalInset) {
        self.init(top: y.top, left: x.left, bottom: y.bottom, right: x.right)
    }
    
}


