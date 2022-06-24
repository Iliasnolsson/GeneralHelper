//
//  Movement.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-11-04.
//

import Foundation

struct Movement<T: Codable>: Codable where T: Equatable {
    var from: T
    var to: T
    
    init(from: T, to: T) {
        self.from = from
        self.to = to
    }
    
    func reversed() -> Movement<T> {
        return .init(from: to, to: from)
    }
    
    enum CodingKeys: String, CodingKey {
        case from = "f"
        case to = "t"
    }
}
