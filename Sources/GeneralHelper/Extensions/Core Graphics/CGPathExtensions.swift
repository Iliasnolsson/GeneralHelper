//
//  CGPathExtensions.swift
//  KognitivKalender
//
//  Created by Ilias Nikolaidis Olsson on 2021-12-03.
//

import QuartzCore

extension CGPath {
    
    static func point(forPercentage t: CGFloat, onCubicPath cubicPath: CubicCurve) -> CGPoint {
        let p0 = cubicPath.start
        let p1 = cubicPath.startTangent
        let p2 = cubicPath.end
        let p3 = cubicPath.endTangent
        
        let xPart1 = (1-t)*(1-t)*(1-t)*p0.x
        let xPart2 = 3*(1-t)*(1-t)*t*p1.x
        let xPart3 = 3*(1-t)*t*t*p2.x;
        let xPart4 = t*t*t*p3.x
        let x = xPart1 + xPart2 + xPart3 + xPart4
        
        let yPart1 = (1-t)*(1-t)*(1-t)*p0.y
        let yPart2 = 3*(1-t)*(1-t)*t*p1.y
        let yPart3 = 3*(1-t)*t*t*p2.y
        let yPart4 = t*t*t*p3.y
        let y = yPart1 + yPart2 + yPart3 + yPart4
        
        return .init(x: x, y: y)
    }
    

    
}
