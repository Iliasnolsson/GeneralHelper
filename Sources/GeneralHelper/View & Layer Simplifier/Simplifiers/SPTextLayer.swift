//
//  SPTextLayer.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-11-14.
//

import QuartzCore

public class SPTextLayer : CATextLayer {
    
    public var alignmentModeVertical: VerticalAlignmentMode = .top
    
    override public func draw(in context: CGContext) {
        if alignmentModeVertical == .center {
            let height = bounds.size.height
            let fontSize = fontSize
            let yDiff = (height-fontSize)/2 - fontSize/10

            context.saveGState()
            context.translateBy(x: 0, y: yDiff) // Use -yDiff when in non-flipped coordinates (like macOS's default)
            super.draw(in: context)
            context.restoreGState()
        }
    }
    
    public enum VerticalAlignmentMode {
        case top
        case center
    }
}
