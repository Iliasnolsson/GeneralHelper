//
//  Time.swift
//  KognitivKalender
//
//  Created by Ilias Nikolaidis Olsson on 2021-11-21.
//

import Foundation

struct Time: Codable, Equatable, Comparable {
    let hour: Int
    let minute: Int
    
    init(hour: Int, minute: Int) {
        self.hour = hour
        self.minute = minute
    }
    
    init(minutesSinceDayBegan: Int) {
        hour = Int((minutesSinceDayBegan.cgFloat / 60).rounded(.down))
        minute = minutesSinceDayBegan - (hour * 60)
    }
    
    func toString() -> String {
        let hourString = hour >= 10 ? hour.description : "0\(hour.description)"
        let minuteString = minute >= 10 ? minute.description : "0\(minute.description)"
        return hourString + ":" + minuteString
    }
    
    func minutesSinceDayBegan() -> Int {
        return (hour * 60) + minute
    }
    
    static func == (lhs: Time, rhs: Time) -> Bool {
        return lhs.hour == rhs.hour && lhs.minute == rhs.minute
    }
    
    static func < (lhs: Time, rhs: Time) -> Bool {
        if lhs.hour == rhs.hour {
            return lhs.minute < rhs.minute
        }
        return lhs.hour < rhs.hour
    }
    
    func add(minutes minutesToAdd: Int) -> Time {
        var newMinute = minute + minutesToAdd
        var newHour = hour
        if newMinute >= 60 {
            let hoursToAdd = newMinute.cgFloat / 60
            newHour += Int(hoursToAdd.rounded(.down))
            newMinute = newMinute - (newHour * 60)
        }
        if newHour > 23 {
            return .init(hour: 24, minute: 00)
        }
        return .init(hour: newHour, minute: newMinute)
    }
    
    func subtract(minutes minutesToSubtract: Int) -> Time {
        var newMinute = minute - minutesToSubtract
        var newHour = hour
        
        if newMinute < 0 {
            let hoursToSubtract = Int((abs(newMinute.cgFloat) / 60).rounded(.up))
            newHour -= hoursToSubtract
            newMinute = hoursToSubtract * 60 - abs(newMinute)
        }
        if newHour < 0 {
            return .init(hour: 0, minute: 0)
        }
        return .init(hour: newHour, minute: newMinute)
    }
    
    private enum CodingKeys: String, CodingKey {
        case hour = "h"
        case minute = "m"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hour = try container.decode(Int.self, forKey: .hour)
        minute = try container.decode(Int.self, forKey: .minute)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(hour, forKey: .hour)
        try container.encode(minute, forKey: .minute)
    }
}
