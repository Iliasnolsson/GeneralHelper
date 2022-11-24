//
//  VerticalInset.swift
//  secret-project
//
//  Created by Ilias Nikolaidis Olsson on 2022-11-23.
//

import UIKit

public struct VerticalInset {
    
    public let top: CGFloat
    public let bottom: CGFloat
    
    public init(top: CGFloat, bottom: CGFloat) {
        self.top = top
        self.bottom = bottom
    }
    
    public init(tb: CGFloat) {
        self.top = tb
        self.bottom = tb
    }

}

// MARK: Helpers
public extension VerticalInset {
    
    func total() -> CGFloat {top + bottom}
    
    func edgeInset() -> UIEdgeInsets {.init(top: top, left: 0, bottom: bottom, right: 0)}
    
    static var zero: VerticalInset = .init(tb: 0)
    
    
}
