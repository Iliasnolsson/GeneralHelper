//
//  Colorable.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-02-09.
//

import UIKit

public protocol Color: ColorGettable {
    associatedtype ValueType = Self
    
    static func initalize(rgba: RGBA) -> ValueType
    
    func rgba() -> RGBA
    
}

public extension Color {
    
    static var black: ValueType {Self.initalize(rgba: RGBA(gray: 0))}
    static var white: ValueType {Self.initalize(rgba: RGBA(gray: 1))}
    static var gray: ValueType {Self.initalize(rgba: RGBA(gray: 0.69))}
    static var clear: ValueType {Self.initalize(rgba: RGBA(r: 0, g: 0, b: 0, a: 0))}
    
    static var green: ValueType {Self.initalize(rgba: .init(r255: 123, g255: 157, b255: 82))}
    static var blue: ValueType {Self.initalize(rgba: .init(r255: 119, g255: 178, b255: 216))}
    static var brown: ValueType {Self.initalize(rgba: .init(r255: 183, g255: 109, b255: 67))}
    static var yellow: ValueType {Self.initalize(rgba: .init(r255: 240, g255: 218, b255: 99))}
    static var pink: ValueType {Self.initalize(rgba: .init(r255: 219, g255: 174, b255: 190))}
    static var red: ValueType {Self.initalize(rgba: .init(r255: 208, g255: 90, b255: 89))}
    
    func interpolate<C: Color>(to toColor: C, amount: CGFloat) -> CGColor {
        let fromRGB = self.rgba()
        let toRGB = toColor.rgba()
        let red = fromRGB.r.interpolateTo(toRGB.r, amount: amount)
        let green = fromRGB.g.interpolateTo(toRGB.g, amount: amount)
        let blue = fromRGB.b.interpolateTo(toRGB.b, amount: amount)
        let alpha = fromRGB.a.interpolateTo(toRGB.a, amount: amount)
        return CGColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func brightness(increaseBy percentage: CGFloat) -> ValueType {
        let hsb = hsba()
        return Self.initalize(rgba: HSBA(h: hsb.h, s: hsb.s, b: hsb.b + percentage, a: hsb.a).rgba())
    }
    
    
    func higlight(percentage: CGFloat) -> ValueType {
        let hsb = hsba()
        var brightnessToAdd: CGFloat = percentage
        if hsb.b == 0 {
            brightnessToAdd = percentage * 1.1
        } else if hsb.b < 0.5 {
            brightnessToAdd = (percentage * (1 - hsb.b)) * 1.1
        } else if hsb.b > 0.5 {
            brightnessToAdd = -percentage * (1 - (hsb.b - 1))
        }
        let hsbaHiglighted = HSBA(h: hsb.h, s: hsb.s, b: hsb.b + brightnessToAdd, a: hsb.a)
        return Self.initalize(rgba: hsbaHiglighted.rgba())
    }
    
    func hsba() -> HSBA {
        let rgb = rgba()
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        rgb.uiColor().getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return .init(h: h, s: s, b: b, a: a)
    }
    
    func uiColor() -> UIColor {
        return UIColor.initalize(rgba: rgba())
    }
    
    func cgColor() -> CGColor {
        return CGColor.initalize(rgba: rgba())
    }
    
}
