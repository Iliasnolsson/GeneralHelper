//
//  IntExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-11-13.
//

import Foundation

extension Int {
    
    func factors() -> [Int] {
        let sqrtn = Int(Double(self).squareRoot())
        var factors: [Int] = []
        factors.reserveCapacity(2 * sqrtn)
        for i in 1...sqrtn {
            if self % i == 0 {
                factors.append(i)
            }
        }
        var j = factors.count - 1
        if factors[j] * factors[j] == self {
            j -= 1
        }
        while j >= 0 {
            factors.append(self / factors[j])
            j -= 1
        }
        return factors
    }

    
}

extension Array where Element == Int {
    
    func delete(atTreePath deletionPath: Self) -> [Int] {
        if deletionPath.isEmpty {return self}
        if count < deletionPath.count {return self}
        
        let indexToDelete: Int = deletionPath.count - 1
        var newPath = self
        if indexToDelete > self.count - 1 {
            return newPath
        }
        
        let oldPathComponent = self[indexToDelete]
        
        if deletionPath.last! < oldPathComponent {
            newPath[indexToDelete] -= 1
        }
        return newPath
    }
    
    func isPositionedAbove(treePath otherTreePath: Self) -> Bool {
        let otherPathNumberOfComponents = otherTreePath.count - 1
        for index in indices {
            if otherPathNumberOfComponents >= index {
                let component = self[index]
                let otherPathComponent = otherTreePath[index]
                if component < otherPathComponent {
                    return true
                } else if component > otherPathComponent {
                    return false
                }
            }
        }
        return false
    }
    
    func isParent(ofTreePath otherTreePath: Self) -> Bool {
        if count >= otherTreePath.count {
            return false
        }
        for index in indices {
            let component = self[index]
            let otherComponent = otherTreePath[index]
            if component != otherComponent {
                return false
            }
        }
        return true
    }
    
}
