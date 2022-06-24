//
//  CALayerExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-24.
//

import QuartzCore

extension CALayer {
    
    var isAnimatable: Bool {
        get { delegate == nil }
        set { delegate = newValue ? nil : CALayerAnimationsDisablingDelegate.shared }
    }
    
    
    private class CALayerAnimationsDisablingDelegate: NSObject, CALayerDelegate {
        static let shared = CALayerAnimationsDisablingDelegate()
        private let null = NSNull()
        
        func action(for layer: CALayer, forKey event: String) -> CAAction? {
            null
        }
    }
    
    static func stopAnimationsIn(_ closure: () -> ()) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        closure()
        CATransaction.commit()
    }
    
    static func animate<T, Layer: CALayer>(layer: Layer, valueKey: WritableKeyPath<Layer, T>, to value: T, duration: CFTimeInterval, delay: CFTimeInterval = 0, option: CAMediaTimingFunction, completion: (() -> ())?) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        let keyString = NSExpression(forKeyPath: valueKey).keyPath
        let animation = CABasicAnimation(keyPath: keyString)
        animation.fromValue = layer[keyPath: valueKey]
        animation.toValue = value
        animation.duration = duration
        animation.beginTime = CACurrentMediaTime() + delay
        animation.fillMode = .forwards
        animation.timingFunction = option
        CATransaction.setCompletionBlock(completion)
        layer.add(animation, forKey: animation.keyPath)
        layer.setValue(value, forKey: keyString)
        CATransaction.commit()
    }
    
    static func animate<T, Layer: CALayer>(layer: Layer, valueKey: WritableKeyPath<Layer, T>, to value: T, duration: CFTimeInterval, option: CAMediaTimingFunction, completion: (() -> ())?) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        let keyString = NSExpression(forKeyPath: valueKey).keyPath
        let animation = CABasicAnimation(keyPath: keyString)
        animation.fromValue = layer[keyPath: valueKey]
        animation.toValue = value
        animation.duration = duration
        animation.fillMode = .forwards
        animation.timingFunction = option
        CATransaction.setCompletionBlock(completion)
        layer.add(animation, forKey: animation.keyPath)
        layer.setValue(value, forKey: keyString)
        CATransaction.commit()
    }
    
    static func animate<T, Layer: CALayer>(layer: Layer, valueKey: WritableKeyPath<Layer, T>, to value: T, duration: CFTimeInterval, option: CAMediaTimingFunction) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        let keyString = NSExpression(forKeyPath: valueKey).keyPath
        let animation = CABasicAnimation(keyPath: keyString)
        animation.fromValue = layer[keyPath: valueKey]
        animation.toValue = value
        animation.duration = duration
        animation.fillMode = .forwards
        animation.timingFunction = option
        layer.add(animation, forKey: animation.keyPath)
        layer.setValue(value, forKey: keyString)
        CATransaction.commit()
    }
    
    func moveTo(point: CGPoint, animated: Bool) {
        if animated {
            let animation = CABasicAnimation(keyPath: "position")
            animation.fromValue = value(forKey: "position")
            animation.toValue = NSValue(cgPoint: point)
            animation.fillMode = .forwards
            self.position = point
            add(animation, forKey: "position")
        } else {
            self.position = point
        }
    }

    func resize(to size: CGSize, animated: Bool) {
        let oldBounds = bounds
        var newBounds = oldBounds
        newBounds.size = size

        if animated {
            let animation = CABasicAnimation(keyPath: "bounds")
            animation.fromValue = NSValue(cgRect: oldBounds)
            animation.toValue = NSValue(cgRect: newBounds)
            animation.fillMode = .forwards
            self.bounds = newBounds
            add(animation, forKey: "bounds")
        } else {
            self.bounds = newBounds
        }
    }
    func resizeAndMove(frame: CGRect, animated: Bool, duration: TimeInterval = 0) {
        if animated {
            let positionAnimation = CABasicAnimation(keyPath: "position")
            positionAnimation.fromValue = value(forKey: "position")
            positionAnimation.toValue = NSValue(cgPoint: CGPoint(x: frame.midX, y: frame.midY))

            let oldBounds = bounds
            var newBounds = oldBounds
            newBounds.size = frame.size

            let boundsAnimation = CABasicAnimation(keyPath: "bounds")
            boundsAnimation.fromValue = NSValue(cgRect: oldBounds)
            boundsAnimation.toValue = NSValue(cgRect: newBounds)

            let groupAnimation = CAAnimationGroup()
            groupAnimation.animations = [positionAnimation, boundsAnimation]
            groupAnimation.fillMode = .forwards
            groupAnimation.duration = duration
            groupAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            self.frame = frame
            add(groupAnimation, forKey: "frame")

        } else {
            self.frame = frame
        }
    }
    
}

extension CALayer {
    
    var scaleX: CGFloat {
        return self.value(forKeyPath: "transform.scale.x") as! CGFloat
    }
    
    var scaleY: CGFloat {
        return self.value(forKeyPath: "transform.scale.y") as! CGFloat
    }
    
    var scale: CGPoint {
        return .init(x: scaleX, y: scaleY)
    }
    
}

