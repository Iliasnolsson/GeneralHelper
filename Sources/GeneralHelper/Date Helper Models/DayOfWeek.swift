//
//  DayOfWeek.swift
//  KognitivKalender
//
//  Created by Ilias Nikolaidis Olsson on 2021-11-20.
//

import Foundation
import UIKit

public enum DayOfWeek: String, Codable, Comparable {
    case monday = "m"
    case tuesday = "t"
    case wednesday = "w"
    case thursday = "h"
    case friday = "f"
    case saturday = "s"
    case sunday = "n"
    
    public init?(dayNumber: Int) {
        switch dayNumber {
        case 1:
            self = .monday
        case 2:
            self = .tuesday
        case 3:
            self = .wednesday
        case 4:
            self = .thursday
        case 5:
            self = .friday
        case 6:
            self = .saturday
        case 7:
            self = .sunday
        default:
            return nil
        }
    }
    
    private var symbolNumber: Int {
        if self == .sunday {
            return 0
        }
        return dayNumber
    }
    
}

public extension DayOfWeek {
    
    var dayNumber: Int {
        switch self {
        case .monday:
            return 1
        case .tuesday:
            return 2
        case .wednesday:
            return 3
        case .thursday:
            return 4
        case .friday:
            return 5
        case .saturday:
            return 6
        case .sunday:
            return 7
        }
    }
    
    func toStringLocalized() -> String {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale.autoupdatingCurrent
        let symbols = calendar.weekdaySymbols
        return symbols[symbolNumber].capitalizingFirstLetter()
    }
    
    static func < (lhs: DayOfWeek, rhs: DayOfWeek) -> Bool {
        return lhs.dayNumber < rhs.dayNumber
    }
    
}
