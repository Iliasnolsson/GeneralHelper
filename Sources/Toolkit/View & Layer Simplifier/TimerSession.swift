//
//  File.swift
//  
//
//  Created by Ilias Nikolaidis Olsson on 2022-11-24.
//

import Foundation

public class TimerSession {
    
    private var timer: Timer?
    
    public init(duration: Double, repeats: Bool = false, closure: @escaping (() -> Void)) {
        timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [weak self] timer in
            closure()
            timer.invalidate()
            self?.timer = nil
        }
    }
    
    public func cancel() {
        timer?.invalidate()
        timer = nil
    }
    
}

public extension Timer {
    
    @discardableResult static func delaySession(_ duration: Double, _ closure: @escaping (() -> Void)) -> TimerSession {
        return .init(duration: duration, closure: closure)
    }
    
}
