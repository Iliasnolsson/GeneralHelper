//
//  Timespan.swift
//  KognitivKalender
//
//  Created by Ilias Nikolaidis Olsson on 2021-11-21.
//

import Foundation

public struct Timespan: Codable, Equatable {
    public let from: Time
    public let to: Time
    
    public init(from: Time, to: Time) {
        self.from = from
        self.to = to
    }
    
    private enum CodingKeys: String, CodingKey {
        case from = "f"
        case to = "t"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        from = try container.decode(Time.self, forKey: .from)
        to = try container.decode(Time.self, forKey: .to)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(from, forKey: .from)
        try container.encode(to, forKey: .to)
    }
    
}

public extension Timespan {
    
    func toString() -> String {
        return from.toString() + "-" + to.toString()
    }
    
    func isClipping(_ otherTimspan: Timespan) -> Bool {
        if from > otherTimspan.from && from < otherTimspan.to {
            return true
        }
        if to < otherTimspan.to && to > otherTimspan.to {
            return true
        }
        if from < otherTimspan.from && to > otherTimspan.to {
            return true
        }
        return false
    }
    
    func durationInMinutes() -> Int {
        return ((to.hour - from.hour) * 60) + (to.minute - from.minute)
    }
    
    static func == (lhs: Timespan, rhs: Timespan) -> Bool {
        return lhs.from == rhs.from && lhs.to == rhs.to
    }
    
}
