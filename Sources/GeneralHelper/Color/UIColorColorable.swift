//
//  UIColor.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-02-09.
//

import UIKit

extension UIColor: Color {
    
    public static func initalize(rgba: RGBA) -> UIColor {
        return UIColor(r: rgba.r, g: rgba.g, b: rgba.b, a: rgba.a, colorSpaceIdentifier: CGColorSpace.sRGB)
    }
    
    public func rgba() -> RGBA {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return .init(r: red, g: green, b: blue, a: alpha)
    }
    
    public func uiColor() -> UIColor {
        return self
    }
    
    public func cgColor() -> CGColor {
        return self.cgColor
    }
    
}
