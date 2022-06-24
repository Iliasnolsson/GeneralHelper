//
//  ClosedRangeExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-07-07.
//

import QuartzCore

extension ClosedRange {
    
    static func add(_ range: ClosedRange<Bound>, with otherRange: ClosedRange<Bound>) -> ClosedRange<Bound> {
        return Swift.min(range.lowerBound, otherRange.lowerBound)...Swift.max(range.upperBound, otherRange.upperBound)
    }
    
    static func add(_ range: ClosedRange<Bound>?, with otherRange: ClosedRange<Bound>?) -> ClosedRange<Bound>? {
        if let range = range, let otherRange = otherRange {
            return Swift.min(range.lowerBound, otherRange.lowerBound)...Swift.max(range.upperBound, otherRange.upperBound)
        } else if range == nil {
            return otherRange
        }
        return range
    }
    
    static func add(_ ranges: [ClosedRange<Bound>]) -> ClosedRange<Bound>? {
        if ranges.isEmpty {return nil}
        
        var rangesMutable = ranges
        let firstRange = rangesMutable.removeFirst()
        var min: Bound = firstRange.lowerBound
        var max: Bound = firstRange.upperBound
        for range in rangesMutable {
            if range.lowerBound < min {
                min = range.lowerBound
            }
            if range.upperBound > max {
                max = range.upperBound
            }
        }
        return min...max
    }
    
}




