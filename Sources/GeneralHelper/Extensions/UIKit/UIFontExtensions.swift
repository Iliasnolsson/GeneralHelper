//
//  UIFontExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-09.
//

import UIKit

public extension UIFont {
    
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

public extension UIFont {
    
    static var largeTitleFontSize: CGFloat =  34
    static var title1FontSize: CGFloat = 28
    static var title2FontSize: CGFloat = 22
    static var title3FontSize: CGFloat = 20
    static var headlineFontSize: CGFloat =  17
    static var bodyFontSize: CGFloat = 17
    static var calloutFontSize: CGFloat = 16
    static var subheadFontSize: CGFloat = 15
    static var footnoteFontSize: CGFloat = 13
    static var caption1FontSize: CGFloat = 12
    static var caption2FontSize: CGFloat = 11
    
}

public extension UIFont {
    
    static func rounded(ofSize size: UIFont.TextStyle, weight: UIFont.Weight = .bold, maxPointSize: CGFloat? = nil) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: 10, weight: weight)
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            return UIFont(descriptor: descriptor, size: 10).with(style: size, maxPointSize: maxPointSize)
        } else {
            return systemFont.with(style: size, maxPointSize: maxPointSize)
        }
    }

    static func display(ofSize size: UIFont.TextStyle, weight: Weight = .medium, maxPointSize: CGFloat? = nil) -> UIFont {
        return UIFont.systemFont(ofSize: 10, weight: weight).with(style: size, maxPointSize: maxPointSize)
    }
    
    func with(style: UIFont.TextStyle, maxPointSize: CGFloat? = nil) -> UIFont {
        if let maxPointSize = maxPointSize {
            return UIFontMetrics(forTextStyle: style).scaledFont(for: self.withSize(style.pointSize),
                                                                 maximumPointSize: maxPointSize)
        }
        return UIFontMetrics(forTextStyle: style).scaledFont(for: self.withSize(style.pointSize))
    }
    
    func with(style: UIFont.TextStyle, basePointSize: CGFloat, maxPointSize: CGFloat? = nil) -> UIFont {
        if let maxPointSize = maxPointSize {
            return UIFontMetrics(forTextStyle: style).scaledFont(for: self.withSize(basePointSize),
                                                                 maximumPointSize: maxPointSize)
        }
        return UIFontMetrics(forTextStyle: style).scaledFont(for: self.withSize(basePointSize))
    }
}


public extension UIFont.TextStyle {
    
    var pointSize: CGFloat {
        switch self {
        case .largeTitle:
            return UIFont.largeTitleFontSize
        case .title1:
            return UIFont.title1FontSize
        case .title2:
            return UIFont.title2FontSize
        case .title3:
            return UIFont.title3FontSize
        case .headline:
            return UIFont.headlineFontSize
        case .body:
            return UIFont.bodyFontSize
        case .callout:
            return UIFont.calloutFontSize
        case .subheadline:
            return UIFont.subheadFontSize
        case .footnote:
            return UIFont.footnoteFontSize
        case .caption1:
            return UIFont.caption1FontSize
        case .caption2:
            return UIFont.caption2FontSize
        default:
            return 0
        }
    }
    
}
