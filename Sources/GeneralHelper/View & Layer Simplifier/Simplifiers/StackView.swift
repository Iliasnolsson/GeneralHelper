//
//  StackView.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-10.
//

import UIKit

class StackView: UIStackView {
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func spacingMultiply(by multiplyer: CGFloat, after arrangedSubview: UIView) {
        setCustomSpacing(spacing * multiplyer, after: arrangedSubview)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

