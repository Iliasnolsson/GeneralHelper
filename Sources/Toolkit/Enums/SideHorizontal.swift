//
//  SideHorizontal.swift
//  SideHorizontal
//
//  Created by Ilias Nikolaidis Olsson on 2021-08-24.
//

import Foundation

public enum SideHorizontal {
    case left
    case right
}

public extension SideHorizontal {
    
    var opposite: SideHorizontal {
        switch self {
        case .left:
            return .right
        case .right:
            return .left
        }
    }
    
}
