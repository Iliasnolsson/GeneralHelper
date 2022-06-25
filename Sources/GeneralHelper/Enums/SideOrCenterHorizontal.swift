//
//  SideOrCenterHorizontal.swift
//  Lotte
//
//  Created by Ilias Nikolaidis Olsson on 2021-12-28.
//

import Foundation

public enum SideOrCenterHorizontal {
    case left
    case center
    case right
}


public extension SideOrCenterHorizontal {
    
    var opposite: SideOrCenterHorizontal {
        switch self {
        case .left:
            return .right
        case .center:
            return .center
        case .right:
            return .left
        }
    }
}
