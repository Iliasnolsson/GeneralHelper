//
//  ObservableLayer.swift
//  ObservableLayer
//
//  Created by Ilias Nikolaidis Olsson on 2021-08-17.
//

import QuartzCore

class CornerObservingLayer: CALayer {
    
    weak var cornerDelegate: CornerObservingLayerDelegate?
    
    override var cornerRadius: CGFloat {
        didSet {
            
            cornerDelegate?.layerCornerRadiusDidChange(to: cornerRadius)
        }
    }
    
    override var maskedCorners: CACornerMask {
        didSet {
            cornerDelegate?.layerCornerMaskDidChange(to: maskedCorners)
        }
    }
    
    
}
