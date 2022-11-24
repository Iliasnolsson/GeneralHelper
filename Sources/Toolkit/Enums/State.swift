//
//  File.swift
//  
//
//  Created by Ilias Nikolaidis Olsson on 2022-11-24.
//

import UIKit

public enum State {
    case began
    case changed
    case ended
}

public extension State {
    
    static func from(_ gestureState: UIGestureRecognizer.State) -> State? {
        switch gestureState {
        case .possible:
            return nil
        case .began:
            return .began
        case .changed:
            return .changed
        case .ended:
            return .ended
        case .cancelled:
            return .ended
        case .failed:
            return nil
        case .recognized:
            return nil
        default:
            return nil
        }
    }
    
}
