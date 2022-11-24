//
//  LinePart.swift
//  secret-project
//
//  Created by Ilias Nikolaidis Olsson on 2022-10-29.
//

import Foundation

public enum SectionOrCenter: String, Codable, Equatable {
    case start = "s"
    case center = "c"
    case end = "e"
    
}

public extension SectionOrCenter {
    
    static func from(_ side: Section) -> SectionOrCenter {
        switch side {
        case .start:
            return .start
        case .end:
            return .end
        }
    }
    
    func on(length: CGFloat) -> CGFloat {
        switch self {
        case .start:
            return 0
        case .center:
            return length * 0.5
        case .end:
            return length
        }
    }
    
}
