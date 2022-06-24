//
//  SideVertical.swift
//  SideVertical
//
//  Created by Ilias Nikolaidis Olsson on 2021-08-24.
//

import Foundation

enum SideVertical {
    case top
    case bottom
 
    var opposite: Side {
        switch self {
        case .top:
            return .bottom
        case .bottom:
            return .top
        }
    }

}
