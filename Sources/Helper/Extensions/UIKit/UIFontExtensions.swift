//
//  UIFontExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-09.
//

import UIKit

extension UIFont {
    
    static func font(ofSize fontSize: CGFloat, weight: UIFont.Weight, design: UIFontDescriptor.SystemDesign) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
        if let descriptor = systemFont.fontDescriptor.withDesign(design) {
            return UIFont(descriptor: descriptor, size: fontSize)
        } else {
            return systemFont
        }
    }
    
    static func rounded(ofSize fontSize: CGFloat, weight: UIFont.Weight = .bold) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            return UIFont(descriptor: descriptor, size: fontSize)
        } else {
            return systemFont
        }
    }

    static func display(ofSize fontSize: CGFloat, weight: Weight = .medium) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: weight)
    }
    
}

