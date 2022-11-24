//
//  File.swift
//  
//
//  Created by Ilias Nikolaidis Olsson on 2022-11-24.
//

import UIKit

public struct Animate {

}

public extension Animate {
    
    
    @discardableResult init(_ duration: Double, damping: CGFloat, velocity: CGFloat, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: velocity, animations: animations, completion: completion)
    }
    
    @discardableResult init(_ duration: Double, damping: CGFloat, velocity: CGFloat, options: UIView.AnimationOptions, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: options, animations: animations, completion: completion)
    }
    
    @discardableResult init(_ duration: Double, delay: Double, damping: CGFloat, velocity: CGFloat, options: UIView.AnimationOptions, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: options, animations: animations, completion: completion)
    }

    static func interactable(_ duration: Double, damping: CGFloat, velocity: CGFloat, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: .allowUserInteraction, animations: animations, completion: completion)
    }

    
}
