//
//  HorizontalInset.swift
//  secret-project
//
//  Created by Ilias Nikolaidis Olsson on 2022-11-23.
//

import UIKit

public struct HorizontalInset {
    
    public let left: CGFloat
    public let right: CGFloat
    
    public init(left: CGFloat, right: CGFloat) {
        self.left = left
        self.right = right
    }
    
    public init(lr: CGFloat) {
        self.left = lr
        self.right = lr
    }

    
}

// MARK: Helpers
public extension HorizontalInset {
    
    func total() -> CGFloat {left + right}
    
    func edgeInset() -> UIEdgeInsets {.init(top: 0, left: left, bottom: 0, right: right)}
    
    static var zero: HorizontalInset = .init(lr: 0)
    
}
