//
//  FloatingPointExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-07-10.
//

import Foundation

extension Array where Element: FloatingPoint {
    
    /// - Returns: Elements in array as percentages relative to max element in array
    func percentagesRelativeToMax() -> [Element] {
        if let max = self.max() {
            return self.map {$0 / max}
        }
        return []
    }
    
    func range() -> ClosedRange<Element>? {
        if self.count < 2 {return nil}
        var lowerBound = self.first!
        var upperBound = lowerBound
        for element in self {
            if element < lowerBound {
                lowerBound = element
            } else if element > upperBound {
                upperBound = element
            }
        }
        return lowerBound == upperBound ? nil : lowerBound...upperBound
    }
    
}
