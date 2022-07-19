//
//  Movement.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-11-04.
//

import Foundation

public struct Movement<T: Codable>: Codable where T: Equatable {
    public var from: T
    public var to: T
    
    public init(from: T, to: T) {
        self.from = from
        self.to = to
    }
    
    enum CodingKeys: String, CodingKey {
        case from = "f"
        case to = "t"
    }
}


public extension Movement {

    func reversed() -> Movement<T> {
        return .init(from: to, to: from)
    }
    
}
