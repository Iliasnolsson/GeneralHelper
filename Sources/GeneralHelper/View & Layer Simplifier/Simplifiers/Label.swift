//
//  LabelView.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-10.
//

import UIKit

public class Label: UILabel {
    
    public init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: Statics
public extension Label {
    
    func setTextColor(_ newColor: UIColor?, animated: Bool, duration: Double) {
        if !animated {textColor = newColor; return}
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve) {
            self.textColor = newColor
        }
    }
    
    static func spacing(forFraction fraction: CGFloat, pointSize: CGFloat) -> CGFloat {
        let pointSizeFraction = pointSize * 0.06
        return -(pointSizeFraction * (1 - fraction))
    }
    
}
