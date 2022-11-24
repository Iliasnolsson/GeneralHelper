//
//  BundleExtensions.swift
//  secret-project
//
//  Created by Ilias Nikolaidis Olsson on 2022-11-18.
//

import Foundation

public extension Bundle {
    static func infoPlistValue(forKey key: String) -> Any? {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) else {
           return nil
        }
        return value
    }
}

