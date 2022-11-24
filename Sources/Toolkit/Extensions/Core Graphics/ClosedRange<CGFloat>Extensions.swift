//
//  File.swift
//  
//
//  Created by Ilias Nikolaidis Olsson on 2022-11-24.
//

import QuartzCore

public extension ClosedRange where Bound == CGFloat {
    
    func path(onAxis axis: Axis, offsetFromOppositeAxis offset: CGFloat) -> CGMutablePath {
        let mutable = CGMutablePath()
        switch axis {
        case .horizontal:
            mutable.move(to: .init(x: lowerBound, y: offset))
            mutable.addLine(to: .init(x: upperBound, y: offset))
        case .vertical:
            mutable.move(to: .init(x: offset, y: upperBound))
            mutable.addLine(to: .init(x: offset, y: lowerBound))
        }
        return mutable
    }
    
}

public extension Array where Element == ClosedRange<CGFloat> {
    
    func filterToExcludeOverlapping() -> [Element] {
        return filterWithContext { remaining, element in
            return !remaining.contains(where: {$0.overlaps(element)})
        }
    }

}
