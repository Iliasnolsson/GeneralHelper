//
//  File.swift
//  
//
//  Created by Ilias Nikolaidis Olsson on 2022-07-13.
//

import UIKit

public enum ColorTheme: Int {
    case dark = 10
    case light = 20
    
    
    public static func from(_ interfaceStyle: UIUserInterfaceStyle) -> ColorTheme {
        return interfaceStyle == .dark ? .dark : .light
    }
    
    static var current: ColorTheme? {
        if let current = UIUserInterfaceStyle.current {
            return .from(current)
        }
        return nil
    }
    
}
