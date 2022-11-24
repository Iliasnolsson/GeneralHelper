//
//  LineSied.swift
//  secret-project
//
//  Created by Ilias Nikolaidis Olsson on 2022-10-29.
//

import QuartzCore

public enum Section {
    case start
    case end
}

public extension Section {
    
    var opposite: Section {self == .start ? .end : .start}
    
}

public extension ClosedRange {
    
    func on(_ side: Section) -> Bound {
        return side == .start ? lowerBound : upperBound
    }
    
}

