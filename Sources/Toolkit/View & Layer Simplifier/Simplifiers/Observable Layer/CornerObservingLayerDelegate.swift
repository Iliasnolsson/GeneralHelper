//
//  ObservableLayerDelegate.swift
//  ObservableLayerDelegate
//
//  Created by Ilias Nikolaidis Olsson on 2021-08-17.
//

import QuickLook

public protocol CornerObservingLayerDelegate: AnyObject {
    
    func layerCornerRadiusDidChange(to newCornerRadius: CGFloat)
    
    func layerCornerMaskDidChange(to newMask: CACornerMask)
    
}


public extension CornerObservingLayerDelegate {
    
    func layerCornerRadiusDidChange(to newCornerRadius: CGFloat) {
    }
    
    func layerCornerMaskDidChange(to newMask: CACornerMask) {
    }
    
}
