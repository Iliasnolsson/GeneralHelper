//
//  Week.swift
//  KognitivKalender
//
//  Created by Ilias Nikolaidis Olsson on 2021-11-20.
//

import Foundation

public struct Week: Codable, Equatable, Comparable, Hashable {
    public let year: Int
    public let weekOfYear: Int

    public init(year: Int, weekOfYear: Int) {
        self.year = year
        self.weekOfYear = weekOfYear
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(year)
        hasher.combine(weekOfYear)
    }
    
    private enum CodingKeys: String, CodingKey {
        case year = "y"
        case weekOfMonth = "w"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        year = try container.decode(Int.self, forKey: .year)
        weekOfYear = try container.decode(Int.self, forKey: .weekOfMonth)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(year, forKey: .year)
        try container.encode(weekOfYear, forKey: .weekOfMonth)
    }
}

public extension Week {
    
    func nextWeek() -> Week {
        let numberOfWeeksForYear = Date.numberOfWeeks(ofYear: year)
        if weekOfYear == numberOfWeeksForYear {
            return .init(year: year + 1, weekOfYear: 1)
        } else {
            return .init(year: year, weekOfYear: weekOfYear + 1)
        }
    }
    
    func previousWeek() -> Week {
        if weekOfYear == 1 {
            return .init(year: year - 1, weekOfYear: Date.numberOfWeeks(ofYear: year - 1))
        } else {
            return .init(year: year, weekOfYear: weekOfYear - 1)
        }
    }
    
    static func < (lhs: Week, rhs: Week) -> Bool {
        if lhs.year < rhs.year {
            if lhs.weekOfYear < rhs.weekOfYear {
                return true
            }
        }
        return false
    }
    
    
    static func ==(lhs: Week, rhs: Week) -> Bool {
        return lhs.year == rhs.year && lhs.weekOfYear == rhs.weekOfYear
    }
    
}
