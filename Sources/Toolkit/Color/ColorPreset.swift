//
//  File.swift
//  
//
//  Created by Ilias Nikolaidis Olsson on 2022-07-13.
//

import Foundation

public enum ColorPresent {
    case white
    case black
    case gray
    case clear
    
    case green
    case blue
    case brown
    case yellow
    case pink
    case red
    
}

public extension ColorPresent {
    
    func rgba() -> RGBA {
        switch self {
        case .white:
            return .white
        case .black:
            return .black
        case .gray:
            return .gray
        case .clear:
            return .clear
        case .green:
            return .green
        case .blue:
            return .blue
        case .brown:
            return .brown
        case .yellow:
            return .yellow
        case .pink:
            return .pink
        case .red:
            return .red
        }
    }
    
}
