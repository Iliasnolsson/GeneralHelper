//
//  DateExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-18.
//

import Foundation

extension Date {
    
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    init(day: Day) {
        let dateForWeek = Date(week: day.week)
        let dateForDay = Calendar(identifier: .gregorian).date(byAdding: .weekday, value: day.dayOfWeek.dayNumber - 1, to: dateForWeek)
        self = dateForDay!
    }
    
    init(week: Week) {
        let calendar = Calendar(identifier: .gregorian)
        let dateForYear = calendar.date(from: .init(year: week.year))!.next(.sunday)
        var dateForWeek = calendar.date(byAdding: .weekOfYear, value: week.weekOfYear - 1, to: dateForYear)!
        dateForWeek = calendar.date(byAdding: .hour, value: 5, to: dateForWeek)!
        self = dateForWeek
    }

    var dayOfWeek: DayOfWeek {
        let dayNumber = Calendar(identifier: .gregorian).dateComponents([.weekday], from: self).weekday!
        return .init(dayNumber: dayNumber)!
    }
    
    var dayOfWeekName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let string = dateFormatter.string(from: self)
        return string
    }
    
    var week: Week {
        let calendar = Calendar(identifier: .gregorian)
        let year = calendar.component(.year, from: self)
        let weekOfYear = calendar.component(.weekOfYear, from: self) - 1
        return .init(year: year, weekOfYear: weekOfYear)
    }
    
    var day: Day {
        let components = Calendar(identifier: .gregorian).dateComponents([.weekday], from: self)
        let weekday = components.weekday!
        let dayOfWeek = {() -> DayOfWeek in
            if weekday == 1 {
                return .sunday
            }
            return DayOfWeek(dayNumber: weekday - 1)!
        }()
        return .init(week: week, dayOfWeek: dayOfWeek)
    }
    
}

extension Date {
    
    static func numberOfWeeks(ofYear year: Int) -> Int {
        func p(_ year: Int) -> Int {
            return (year + year/4 - year/100 + year/400) % 7
        }
        return (p(year) == 4 || p(year-1) == 3) ? 53 : 52
    }
    
    static func firstMonday(ofYear year: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var date = calendar.date(from: .init(year: year))!.next(.sunday)
        date = calendar.date(byAdding: .hour, value: 5, to: date)!
        return date
    }
    
    
}

extension Date {

  static func today() -> Date {
      return Date()
  }

  func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.next,
               weekday,
               considerToday: considerToday)
  }

  func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.previous,
               weekday,
               considerToday: considerToday)
  }

  func get(_ direction: SearchDirection,
           _ weekDay: Weekday,
           considerToday consider: Bool = false) -> Date {

    let dayName = weekDay.rawValue

    let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }

    assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")

    let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 2

    let calendar = Calendar(identifier: .gregorian)

    if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
      return self
    }

    var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
    nextDateComponent.weekday = searchWeekdayIndex

    let date = calendar.nextDate(after: self,
                                 matching: nextDateComponent,
                                 matchingPolicy: .nextTime,
                                 direction: direction.calendarSearchDirection)

    return date!
  }

}

// MARK: Helper methods
extension Date {
  func getWeekDaysInEnglish() -> [String] {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "en_US_POSIX")
    return calendar.weekdaySymbols
  }

  enum Weekday: String {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
  }

  enum SearchDirection {
    case next
    case previous

    var calendarSearchDirection: Calendar.SearchDirection {
      switch self {
      case .next:
        return .forward
      case .previous:
        return .backward
      }
    }
  }
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}
