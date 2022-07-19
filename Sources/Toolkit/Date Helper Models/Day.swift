//
//  Day.swift
//  KognitivKalender
//
//  Created by Ilias Nikolaidis Olsson on 2021-11-20.
//

import Foundation

public struct Day: Codable, Equatable, Hashable {
    public let dayOfWeek: DayOfWeek
    public let week: Week
    
    public init(week: Week, dayOfWeek: DayOfWeek) {
        self.week = week
        self.dayOfWeek = dayOfWeek
    }
    
    public static func ==(lhs: Day, rhs: Day) -> Bool {
        return lhs.dayOfWeek == rhs.dayOfWeek && lhs.week == rhs.week
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(week)
        hasher.combine(dayOfWeek)
    }
    
    private enum CodingKeys: String, CodingKey {
        case dayOfWeek = "d"
        case week = "w"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dayOfWeek = try container.decode(DayOfWeek.self, forKey: .dayOfWeek)
        week = try container.decode(Week.self, forKey: .week)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dayOfWeek, forKey: .dayOfWeek)
        try container.encode(week, forKey: .week)
    }
    
}
