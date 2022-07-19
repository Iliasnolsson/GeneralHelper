//
//  SideVertical.swift
//  SideVertical
//
//  Created by Ilias Nikolaidis Olsson on 2021-08-24.
//

import Foundation

public enum SideVertical {
    case top
    case bottom

}

public extension SideVertical {
    
    var opposite: Side {
        switch self {
        case .top:
            return .bottom
        case .bottom:
            return .top
        }
    }

}
