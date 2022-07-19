//
//  UIControlExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-09-27.
//

import UIKit

public extension UIControl {
    
    @available(iOS 14.0, *)
    func addTarget(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        addAction(UIAction { (action: UIAction) in closure() }, for: controlEvents)
    }
    
}
