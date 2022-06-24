//
//  SideOrCenterHorizontal.swift
//  Lotte
//
//  Created by Ilias Nikolaidis Olsson on 2021-12-28.
//

import Foundation

enum SideOrCenterHorizontal {
    case left
    case center
    case right
    
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
