//
//  File.swift
//  
//
//  Created by Ilias Nikolaidis Olsson on 2022-11-24.
//

import QuartzCore

public struct RGB: Color, Codable {
    
    public var r: CGFloat
    public var g: CGFloat
    public var b: CGFloat
    
    public init() {
        r = 0
        g = 0
        b = 0
    }
    
    public init(gray: CGFloat) {
        r = gray
        g = gray
        b = gray
    }
    
    public init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.r = r
        self.g = g
        self.b = b
    }
    
    public init(r: Double, g: Double, b: Double, a: Double, denominator: ColorFormatDenominator = .One) {
        self.r = r / denominator.value
        self.g = g / denominator.value
        self.b = b / denominator.value
    }
    
    public init(r255: CGFloat, g255: CGFloat, b255: CGFloat) {
        self.init(r: r255/255, g: g255/255, b: b255/255)
    }
    
    private enum CodingKeys: String, CodingKey {
        case r = "r"
        case g = "g"
        case b = "b"
    }
    
}

// MARK: Codable
public extension RGB {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        r = try container.decode(CGFloat.self, forKey: .r)
        g = try container.decode(CGFloat.self, forKey: .g)
        b = try container.decode(CGFloat.self, forKey: .b)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(r, forKey: .r)
        try container.encode(g, forKey: .g)
        try container.encode(b, forKey: .b)
    }
    
}

// MARK: Equatable
extension RGB: Equatable {
    
    public static func == (lhs: RGB, rhs: RGB) -> Bool {
        return lhs.r == rhs.r && lhs.g == rhs.g && lhs.b == rhs.b
    }
    
}

public extension RGB {
    
    static func initalize(rgba: RGBA) -> RGBA {
        return .init(r: rgba.r, g: rgba.g, b: rgba.b)
    }
    
    func rgba() -> RGBA {
        return .init(r: r, g: g, b: b, a: 1)
    }
    
}

