//
//  CATransform3D.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-07-09.
//

import Foundation
import QuartzCore

extension CATransform3D {
    
    init(_ affine: CGAffineTransform) {
        self = CATransform3DMakeAffineTransform(affine)
    }
    
    static var identity: CATransform3D {
        return CATransform3DIdentity
    }
    
    static func scale(x: CGFloat, y: CGFloat) -> CATransform3D {
        return CATransform3DMakeScale(x, y, 1)
    }
    
    static func translate(x: CGFloat, y: CGFloat) -> CATransform3D {
        return CATransform3DMakeTranslation(x, y, 0)
    }
    
    static func rotate(by radians: CGFloat) -> CATransform3D {
        return CATransform3DMakeRotation(radians, 0, 0, 1)
    }
    
    
    var scaleX: CGFloat {
        let numbLayer = CALayer()
        numbLayer.transform = self
        return numbLayer.value(forKeyPath: "transform.scale.x") as! CGFloat
    }
    
    var scaleY: CGFloat {
        let numbLayer = CALayer()
        numbLayer.transform = self
        return numbLayer.value(forKeyPath: "transform.scale.y") as! CGFloat
    }
    
    var scale: CGPoint {
        let numbLayer = CALayer()
        numbLayer.transform = self
        let scaleX = numbLayer.value(forKeyPath: "transform.scale.x") as! CGFloat
        let scaleY = numbLayer.value(forKeyPath: "transform.scale.y") as! CGFloat
        return CGPoint(x: scaleX, y: scaleY)
    }
    
    var position: CGPoint {
        let numbLayer = CALayer()
        numbLayer.transform = self
        let x = numbLayer.value(forKeyPath: "transform.translation.x") as! CGFloat
        let y = numbLayer.value(forKeyPath: "transform.translation.y") as! CGFloat
        return CGPoint(x: x, y: y)
    }

    /// Rotation in Radians
    var rotation: CGFloat {
        let numbLayer = CALayer()
        numbLayer.transform = self
        let radians = numbLayer.value(forKeyPath: "transform.rotation") as! CGFloat
        return radians
    }
    
}
