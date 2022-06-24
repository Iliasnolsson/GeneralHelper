//
//  CGSizeExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-09.
//

import CoreGraphics

extension CGSize {
    
    init(_ point: CGPoint) {
        self.init(width: point.x, height: point.y)
    }
    
    init(wh: CGFloat) {
        self.init(width: wh, height: wh)
    }
    
    var pointValue: CGPoint {
        return .init(x: width, y: height)
    }
    
    func scaleToFit(in targetSize: CGSize) -> CGFloat {
        let targetRatio = targetSize.width / targetSize.height
        let fromRatio = width / height
        return targetRatio > fromRatio ? targetSize.height / height : targetSize.width / width;
    }
    
}
