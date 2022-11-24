//
//  CGRectRotated.swift
//  secret-project
//
//  Created by Ilias Nikolaidis Olsson on 2022-11-07.
//

import QuartzCore

public struct CGRectRotated: Codable, Equatable {
    
    public var origin: CGPoint
    public var size: CGSize
    public var rotation: CGFloat
    
    public init(origin: CGPoint, size: CGSize, rotation: CGFloat) {
        self.origin = origin
        self.size = size
        self.rotation = rotation
    }
    
    public init(rect: CGRect, rotation: CGFloat) {
        self.origin = rect.origin
        self.size = rect.size
        self.rotation = rotation
    }
    
    private enum CodingKeys: String, CodingKey {
        case origin = "o"
        case size = "s"
        case rotation = "r"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        origin = try container.decode(CGPoint.self, forKey: .origin)
        size = try container.decode(CGSize.self, forKey: .size)
        rotation = try container.decode(CGFloat.self, forKey: .rotation)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(origin, forKey: .origin)
        try container.encode(size, forKey: .size)
        try container.encode(rotation, forKey: .rotation)
    }
    
    public static func ==(lhs: CGRectRotated, rhs: CGRectRotated) -> Bool {
        return lhs.origin == rhs.origin && lhs.size == rhs.size && lhs.rotation == rhs.rotation
    }
    
}

public extension CGRectRotated {
    
    func location(forAnchor anchor: RectangleAnchor) -> CGPoint {
        let location = rect.location(forAnchor: anchor)
        return (location - origin).applying(.init(rotateDegrees: rotation)) + origin
    }
    
    func rotated(byDegrees degrees: CGFloat, around center: CGPoint) -> CGRectRotated {
        let origin = origin.applying(.identity.rotate(by: -rotation.toRadians(), around: center))
        
        let relativeRotationCenter = center - origin
        var transform = CGAffineTransform(translationX: origin.x, y: origin.y)
        transform = transform.rotate(by: (degrees + rotation).toRadians(), around: relativeRotationCenter)
        
        return .init(origin: transform.position, size: size, rotation: transform.rotation.toDegrees())
    }
    
}

// MARK: Helpers
public extension CGRectRotated {
    
    var rect: CGRect {.init(origin: origin, size: size)}
    
}

// MARK: Extensions
public extension CGRectRotated {
    
    func origin(translateBy translation: CGPoint) -> CGRectRotated {
        return .init(origin: origin + translation, size: size, rotation: rotation)
    }
    
    func origin(translateBy translation: CGFloat, axis: Axis) -> CGRectRotated {
        return axis == .horizontal ? origin(xTranslateBy: translation) : origin(yTranslateBy: translation)
    }
    
    private func origin(xTranslateBy translation: CGFloat) -> CGRectRotated {
        return .init(origin: .init(x: translation + origin.x, y: origin.y), size: size, rotation: rotation)
    }
    
    private func origin(yTranslateBy translation: CGFloat) -> CGRectRotated {
        return .init(origin: .init(x: origin.x, y: origin.y + translation), size: size, rotation: rotation)
    }
    
}


