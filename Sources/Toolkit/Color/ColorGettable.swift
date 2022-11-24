//
//  ColorGettable.swift
//  old-version-of-secret-project
//
//  Created by Ilias Nikolaidis Olsson on 2021-12-12.
//

import UIKit

public protocol ColorGettable {
    
    func uiColor() -> UIColor
    func cgColor() -> CGColor
    func rgba() -> RGBA
    func hsba() -> HSBA
    
}


