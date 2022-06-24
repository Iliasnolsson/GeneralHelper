//
//  CGAffineTransformExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-18.
//

import QuartzCore

extension CGAffineTransform {
    
    init(scaleXY: CGFloat) {
        self.init(scaleX: scaleXY, y: scaleXY)
    }
    
    init(rotateDegrees: CGFloat) {
        self.init(rotationAngle: rotateDegrees.toRadians())
    }
    
    func rotated(byDegrees degrees: CGFloat) -> CGAffineTransform {
        return self.rotated(by: degrees.toRadians())
    }
    
    func rotate(by radians: CGFloat, around point: CGPoint, initalScale: CGPoint = CGPoint(x: 1, y: 1)) -> CGAffineTransform {
        var affine: CGAffineTransform = self
        affine = affine.translatedBy(x: point.x, y: point.y)
        affine = affine.scaledBy(x: 1 / initalScale.x, y: 1 / initalScale.y)
        affine = affine.rotated(by: radians)
        affine = affine.scaledBy(x: initalScale.x, y: initalScale.y)
        affine = affine.translatedBy(x: -point.x, y: -point.y)
        return affine
    }
    
    func scale(by scale: CGPoint, from fromPoint: CGPoint) -> CGAffineTransform {
        var affine = self
        affine = affine.translatedBy(x: fromPoint.x, y: fromPoint.y)
        affine = affine.scaledBy(x: scale.x, y: scale.y)
        affine = affine.translatedBy(x: -fromPoint.x, y: -fromPoint.y)
        return affine
    }
    
    var scaleX: CGFloat {
        return CATransform3D.init(self).scaleX
    }
    
    var scaleY: CGFloat {
        return CATransform3D.init(self).scaleY
    }
    
    var scale: CGPoint {
        return CATransform3D.init(self).scale
    }
    
    var position: CGPoint {
        return CATransform3D.init(self).position
    }
    
    /// Rotation in Radians
    var rotation: CGFloat {
        return CATransform3D.init(self).rotation
    }
    
    public init(position: CGPoint, rotation: CGFloat, scale: CGSize)  {
        var affine: CGAffineTransform = .identity
        affine = CGAffineTransform(translationX: position.x, y: position.y)
        affine = affine.rotated(by: rotation)
        affine = affine.scaledBy(x: scale.width, y: scale.height)
        self = affine
    }
    
    func scaledBy(size: CGSize) -> CGAffineTransform {
        return self.scaledBy(x: size.width, y: size.height)
    }
    
    func scaledBy(point: CGPoint) -> CGAffineTransform {
        return self.scaledBy(x: point.x, y: point.y)
    }
    
    func translatedBy(point: CGPoint) -> CGAffineTransform {
        return self.translatedBy(x: point.x, y: point.y)
    }
    
    public init(position: CGPoint, rotation: CGFloat, scale: CGSize, anchor: CGPoint) {
        self = CGAffineTransform(position: position, rotation: rotation, scale: scale).translatedBy(x: -anchor.x, y: -anchor.y)
    }
    
}
