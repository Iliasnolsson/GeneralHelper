//
//  CGPathExtensions.swift
//  KognitivKalender
//
//  Created by Ilias Nikolaidis Olsson on 2021-12-03.
//

import QuartzCore

public extension CGPath {
    
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

public extension CGPath {
    
    static func rounded(rect: CGRect,
                        topLeft topLeftRadius: CGFloat,
                        topRight topRightRadius: CGFloat,
                        bottomLeft bottomLeftRadius: CGFloat,
                        bottomRight bottomRightRadius: CGFloat) -> CGMutablePath {
        let path = CGMutablePath()
        
        if [topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius].allSatisfy({$0.isZero}) {
            return CGMutablePath(rect: rect, transform: nil)
        }
        
        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        
        if topLeftRadius != .zero {
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        if topRightRadius != .zero {
            path.addLine(to: CGPoint(x: topRight.x-topRightRadius, y: topRight.y))
            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius))
        } else {
            path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }
        
        if bottomRightRadius != .zero {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius))
            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }
        
        if bottomLeftRadius != .zero {
            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }
        
        if topLeftRadius != .zero {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius))
            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        path.closeSubpath()
        return path
    }
    
}

public extension Array where Element: CGPath {
    
    func boundingBoxOfAllPaths() -> CGRect? {
        return map({$0.boundingBoxOfPath}).boundingRect()
    }
    
}
