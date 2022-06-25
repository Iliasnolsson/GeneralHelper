//
//  ColorExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-09-26.
//

import UIKit

public extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat, colorSpaceIdentifier: CFString = CGColorSpace.sRGB) {
        let colorSpace = CGColorSpace(name: colorSpaceIdentifier)!
        self.init(cgColor: .init(colorSpace: colorSpace, components: [r, g, b, a])!)
    }
    
    convenience init(r255: CGFloat, g255: CGFloat, b255: CGFloat, a1: CGFloat, colorSpaceIdentifier: CFString = CGColorSpace.sRGB) {
        self.init(r: r255/255, g: g255/255, b: b255/255, a: a1, colorSpaceIdentifier: colorSpaceIdentifier)
    }
    
    convenience init<T: Color>(light: T, dark: T) {
        self.init { trait in
            return trait.userInterfaceStyle == .light ? light.uiColor() : dark.uiColor()
        }
    }
    
    convenience init<T: Color>(light: T, dark: T?) {
        self.init { trait in
            return trait.userInterfaceStyle == .light ? light.uiColor() : (dark ?? light).uiColor()
        }
    }
    
    static var appTintColor: UIColor {.systemBlue}
    
}
