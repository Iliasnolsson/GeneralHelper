//
//  SideHorizontal.swift
//  SideHorizontal
//
//  Created by Ilias Nikolaidis Olsson on 2021-08-24.
//

import Foundation

enum SideHorizontal {
    case left
    case right
    
    var opposite: Side {
        switch self {
        case .left:
            return .right
        case .right:
            return .left
        }
    }
}
