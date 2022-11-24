//
//  ClosedRangeExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-07-07.
//

import QuartzCore

public extension ClosedRange {
    
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

public extension ClosedRange {
    
    func contains(_ otherRange: ClosedRange) -> Bool {
        return lowerBound <= otherRange.lowerBound && upperBound <= otherRange.upperBound
    }
    
    func positioned(onSideOf otherRange: ClosedRange) -> SideHorizontal? {
        if upperBound < otherRange.lowerBound {
            return .left
        }
        if lowerBound > otherRange.upperBound {
            return .right
        }
        return nil
    }
    
    func add(_ range: ClosedRange<Bound>) -> ClosedRange<Bound> {
        let lowestBound = Swift.min(lowerBound, range.lowerBound)
        let highestBound = Swift.max(upperBound, range.upperBound)
        return lowestBound...highestBound
    }
    
}
