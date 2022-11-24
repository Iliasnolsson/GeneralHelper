//
//  CGSizeExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-09.
//

import CoreGraphics

public extension CGSize {
    
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
    
    func max() -> CGFloat {
        return Swift.max(width, height)
    }
    
    func min() -> CGFloat {
        return Swift.min(width, height)
    }
    
    func rounded(decimal: CGFloat) -> CGSize {
        return .init(width: width.rounded(decimal: decimal), height: height.rounded(decimal: decimal))
    }
    
}
