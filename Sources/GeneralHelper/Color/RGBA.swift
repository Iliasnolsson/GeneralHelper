//
//  RGBA.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-02-09.
//

import QuartzCore

public struct RGBA: Color {
    
    public var r: CGFloat
    public var g: CGFloat
    public var b: CGFloat
    public var a: CGFloat
    
    public init() {
        r = 0
        g = 0
        b = 0
        a = 0
    }
    
    public init(gray: CGFloat, a: CGFloat = 1) {
        r = gray
        g = gray
        b = gray
        self.a = a
    }
    
    public init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }
    
    public init(r: Double, g: Double, b: Double, a: Double, denominator: ColorFormatDenominator = .One) {
        self.r = r / denominator.value
        self.g = g / denominator.value
        self.b = b / denominator.value
        self.a = a / denominator.value
    }
    
    public init(r255: CGFloat, g255: CGFloat, b255: CGFloat, a1: CGFloat = 1) {
        self.init(r: r255/255, g: g255/255, b: b255/255, a: a1)
    }
    
}


public extension RGBA {
    
    
    static func initalize(rgba: RGBA) -> RGBA {
        return rgba
    }
    
    func rgba() -> RGBA {
        return self
    }
    
}
