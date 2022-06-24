//
//  Timer.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-07-27.
//

import Foundation

extension Timer {
    
    static func delay(_ duration: Double, _ closure: @escaping (() -> ())) {
        Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { timer in
            closure()
        }
    }
   
}
