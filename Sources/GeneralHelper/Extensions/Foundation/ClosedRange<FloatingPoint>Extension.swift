//
//  ClosedRangePointExtension.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-07-07.
//

import QuartzCore

extension ClosedRange where Bound: FloatingPoint {
    
    func lengthExpand(by value: Bound) -> ClosedRange<Bound> {
        return (self.lowerBound - value)...(self.upperBound + value)
    }
    
    func upperBoundAdd(_ value: Bound) -> ClosedRange<Bound> {
        return self.lowerBound...(self.upperBound + value)
    }
    
    func lowerBoundAdd(_ value: Bound) -> ClosedRange<Bound> {
        return (self.lowerBound - value)...self.upperBound
    }
    
}
 
