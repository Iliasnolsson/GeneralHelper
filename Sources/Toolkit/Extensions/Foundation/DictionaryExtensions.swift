//
//  File.swift
//  
//
//  Created by Ilias Nikolaidis Olsson on 2022-11-24.
//

import Foundation

public extension Dictionary {
    
    func mapKeys<NewKey: Hashable>(_ transform: (Key) throws -> NewKey) rethrows -> Dictionary<NewKey, Value> {
        var newDict = [NewKey : Value]()
        for (key, value) in self {
            let newKey = try transform(key)
            newDict[newKey] = value
        }
        return newDict
    }
    
}
