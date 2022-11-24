//
//  PresentationType.swift
//  old-version-of-secret-project
//
//  Created by Ilias Nikolaidis Olsson on 2021-12-29.
//

import Foundation

public enum PresentationType {
    case present
    case dismiss
}

public extension PresentationType {
    
    var isPresenting: Bool {
        return self == .present
    }
}
