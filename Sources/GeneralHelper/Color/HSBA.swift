//
//  HSBA.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-02-09.
//

import UIKit

public struct HSBA: Codable, Color {
    public var h: CGFloat
    public var s: CGFloat
    public var b: CGFloat
    public var a: CGFloat
    
    public init() {
        h = 0
        s = 0
        b = 0
        a = 0
    }

    public init(h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.h = h
        self.s = s
        self.b = b
        self.a = a
    }
    
}

public extension HSBA {
    
    static func initalize(rgba: RGBA) -> HSBA {
        return rgba.hsba()
    }
    
    func hsba() -> HSBA {
        return self
    }
    
    func uiColor() -> UIColor {
        return UIColor(hue: h, saturation: s, brightness: b, alpha: a)
    }
    
    func cgColor() -> CGColor {
        return UIColor(hue: h, saturation: s, brightness: b, alpha: a).cgColor
    }
    
    func rgba() -> RGBA {
        let ciColor = CIColor(color: UIColor(hue: h, saturation: s, brightness: b, alpha: a))
        return RGBA(r: ciColor.red, g: ciColor.green, b: ciColor.blue, a: ciColor.alpha)
    }
    
}
