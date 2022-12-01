//
//  CGPointExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-09.
//

import CoreGraphics

public extension CGPoint {
    
    func rotate(around: CGPoint, byDegrees: CGFloat) -> CGPoint {
        return rotate(around: around, byAngle: byDegrees)
    }
    
    func rotate(around: CGPoint, byAngle: CGFloat) -> CGPoint {
        let rotationSin = sin(byAngle)
        let rotationCos = cos(byAngle)
        let x = (self.x * rotationCos - self.y * rotationSin) + around.x
        let y = (self.x * rotationSin + self.y * rotationCos) + around.y
        return CGPoint(x: x, y: y)
    }
    
    /// - Returns: Rotation in radians around center
    func rotation(around center: CGPoint) -> CGFloat {
        let deltaX = x - center.x
        let deltaY = y - center.y
        let radians = atan2(deltaY, deltaX)
        return radians
    }

    func translationToScale(translationFor2xScale translationFor2x: CGFloat = 200) -> CGFloat {
        var multiplierX = abs(x) / translationFor2x
        var multiplierY = abs(y) / translationFor2x
        multiplierX = 1 + (x < 0 ? -multiplierX : multiplierX)
        multiplierY = 1 + (y > 0 ? -multiplierY : multiplierY)
        return ((multiplierX - 1) + (multiplierY - 1)) + 1
    }
    
    func angle(inCircleWithCenter center: CGPoint, toPointOnCircle: CGPoint) -> CGFloat {
        let p1 = self
        let p2 = toPointOnCircle
        let v1 = CGVector(dx: p1.x - center.x, dy: p1.y - center.y)
        let v2 = CGVector(dx: p2.x - center.x, dy: p2.y - center.y)
        let angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
        return angle
    }
    
    static func pointOnCircle(withCenter center: CGPoint, radius: CGFloat, atAngle angle: CGFloat) -> CGPoint {
        let x = center.x + radius * cos(angle)
        let y = center.y + radius * sin(angle)
        
        return CGPoint(x: x, y: y)
    }
    
    func scale(from fromPoint: CGPoint, by scale: CGPoint) -> CGPoint {
        let xScaled = (x - fromPoint.x) * scale.x
        let yScaled = (y - fromPoint.y) * scale.y
        return CGPoint(x: xScaled + fromPoint.x, y: yScaled + fromPoint.y)
    }
    
    func scale(forReaching target: CGPoint, byScalingFrom from: CGPoint) -> CGPoint {
        let xScale = (target.x - from.x) / (x - from.x)
        let yScale = (target.y - from.y) / (y - from.y)
        return .init(x: xScale, y: yScale)
    }
    
    init(_ size: CGSize) {
        self.init(x: size.width, y: size.height)
    }
    
    init(xy: CGFloat) {
        self.init(x: xy, y: xy)
    }
    
    func add(x: CGFloat) -> CGPoint {
        return .init(x: self.x + x, y: self.y)
    }
    
    func add(y: CGFloat) -> CGPoint {
        return .init(x: self.x, y: self.y + y)
    }

    func subtract(x: CGFloat) -> CGPoint {
        return .init(x: self.x - x, y: self.y)
    }
    
    func subtract(y: CGFloat) -> CGPoint {
        return .init(x: self.x, y: self.y - y)
    }
    
    func divide(xBy divider: CGFloat) -> CGPoint {
        return .init(x: self.x / divider, y: self.y)
    }
    
    func divide(yBy divider: CGFloat) -> CGPoint {
        return .init(x: self.x, y: self.y / divider)
    }
    
    func multiply(xBy multiplier: CGFloat) -> CGPoint {
        return .init(x: self.x * multiplier, y: self.y)
    }
    
    func multiply(yBy multiplier: CGFloat) -> CGPoint {
        return .init(x: self.x, y: self.y * multiplier)
    }
    
    var sizeValue: CGSize {
        return .init(width: x, height: y)
    }
    
    func max() -> CGFloat {
        return Swift.max(x, y)
    }
    
    func min() -> CGFloat {
        return Swift.min(x, y)
    }
    
}

