//
//  StackView.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-10.
//

import UIKit

open class StackView: UIStackView {
    
    public init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func spacingMultiply(by multiplyer: CGFloat, after arrangedSubview: UIView) {
        setCustomSpacing(spacing * multiplyer, after: arrangedSubview)
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

