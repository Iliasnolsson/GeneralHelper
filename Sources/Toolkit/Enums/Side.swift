//
//  Side.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-23.
//

import QuartzCore

public enum Side {
    case top
    case bottom
    case left
    case right
    
}

public extension Side {
    
    init(horizontal side: SideHorizontal) {
        switch side {
        case .left:
            self = .left
        case .right:
            self = .right
        }
    }
    
    init(vertical side: SideVertical) {
        switch side {
        case .top:
            self = .top
        case .bottom:
            self = .bottom
        }
    }
    
    var opposite: Side {
        switch self {
        case .top:
            return .bottom
        case .bottom:
            return .top
        case .left:
            return .right
        case .right:
            return .left
        }
    }
    
    var axisUsedForDrawing: Axis {
        switch self {
        case .top:
            return .horizontal
        case .bottom:
            return .horizontal
        case .left:
            return .vertical
        case .right:
            return .vertical
        }
    }
    
    var centerAnchor: RectangleAnchor {
        switch self {
        case .top:
            return .topCenter
        case .bottom:
            return .bottomCenter
        case .left:
            return .leftCenter
        case .right:
            return .rightCenter
        }
    }
    
    static var allCases: [Side] {[.top, .bottom, .left, .right]}
    
}

public extension CGRect {
    
    func float(forSide side: Side) -> CGFloat {
        switch side {
        case .top:
            return minY
        case .bottom:
            return maxY
        case .left:
            return minX
        case .right:
            return maxX
        }
    }
    
    func range(forSide side: Side) -> ClosedRange<CGFloat> {
        if side == .top || side == .bottom {
            return minX...maxX
        }
        return minY...maxY
    }
    
    func side(forLocation point: CGPoint, excludeSides: [Side] = []) -> (Side, distance: CGFloat) {
        let sides = Side.allCases.filter {!excludeSides.contains($0)}
        var sidesAndDistance = [(side: Side, distance: CGFloat)]()
        for side in sides {
            var nearestFloatOnLine = point.float(onAxis: side.axisUsedForDrawing)
            let lineFloatRange = range(forSide: side)
            nearestFloatOnLine = nearestFloatOnLine.clamp(lineFloatRange.lowerBound, lineFloatRange.upperBound)
            
            var nearestPointOnLine = CGPoint()
            nearestPointOnLine.set(nearestFloatOnLine, onAxis: side.axisUsedForDrawing)
            nearestPointOnLine.set(float(forSide: side), onAxis: side.axisUsedForDrawing.opposite)

            sidesAndDistance.append((side, nearestPointOnLine.distanceTo(point)))
        }
        return sidesAndDistance.min(by: {a, b in a.distance < b.distance})!
    }
    
    
}
