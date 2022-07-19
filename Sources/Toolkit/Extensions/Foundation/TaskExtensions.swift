//
//  File.swift
//  
//
//  Created by Ilias Nikolaidis Olsson on 2022-07-18.
//

import Foundation

public extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
    
    static func delay(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.delay(nanoseconds: duration)
    }
    
    static func delay(nanoseconds: UInt64) async throws {
        try await Task.sleep(nanoseconds: nanoseconds)
    }
}
