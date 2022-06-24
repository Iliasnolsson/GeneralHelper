//
//  Day.swift
//  KognitivKalender
//
//  Created by Ilias Nikolaidis Olsson on 2021-11-20.
//

import Foundation

struct Day: Codable, Equatable, Hashable {
    let dayOfWeek: DayOfWeek
    let week: Week
    
    init(week: Week, dayOfWeek: DayOfWeek) {
        self.week = week
        self.dayOfWeek = dayOfWeek
    }
    
    static func ==(lhs: Day, rhs: Day) -> Bool {
        return lhs.dayOfWeek == rhs.dayOfWeek && lhs.week == rhs.week
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(week)
        hasher.combine(dayOfWeek)
    }
    
    private enum CodingKeys: String, CodingKey {
        case dayOfWeek = "d"
        case week = "w"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dayOfWeek = try container.decode(DayOfWeek.self, forKey: .dayOfWeek)
        week = try container.decode(Week.self, forKey: .week)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dayOfWeek, forKey: .dayOfWeek)
        try container.encode(week, forKey: .week)
    }
    
}
