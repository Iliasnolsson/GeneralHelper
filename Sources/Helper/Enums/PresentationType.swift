//
//  PresentationType.swift
//  Lotte
//
//  Created by Ilias Nikolaidis Olsson on 2021-12-29.
//

import Foundation

enum PresentationType {
    
    case present
    case dismiss
    
    var isPresenting: Bool {
        return self == .present
    }
}
