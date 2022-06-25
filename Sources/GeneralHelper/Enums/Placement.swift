//
//  Placement.swift
//  KognitivKalender
//
//  Created by Ilias Nikolaidis Olsson on 2021-12-05.
//

import Foundation

public enum Placement {
    case over
    case under
    case left
    case right
    
}

public extension Placement {
    
    var opposite: Side {
        switch self {
        case .over:
            return .bottom
        case .under:
            return .top
        case .left:
            return .right
        case .right:
            return .left
        }
    }
    
    var axis: Axis {
        switch self {
        case .over:
            return .vertical
        case .under:
            return .vertical
        case .left:
            return .horizontal
        case .right:
            return .horizontal
        }
    }
    
}
