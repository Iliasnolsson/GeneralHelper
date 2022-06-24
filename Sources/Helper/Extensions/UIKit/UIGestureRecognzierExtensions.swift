//
//  UIGestureRecognzierExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-18.
//

import UIKit
 
extension UIGestureRecognizer {
    
    var isActive: Bool {
        let activeStates: [UIGestureRecognizer.State] = [.began, .changed, .ended]
        return activeStates.contains(self.state)
    }
    
}

extension UIGestureRecognizer.State {
    
    
    var isFinalState: Bool {
        if self == .cancelled {
            return true
        }
        if self == .ended {
            return true
        }
        return false
    }
    
}
