//
//  ColorGettable.swift
//  Lotte
//
//  Created by Ilias Nikolaidis Olsson on 2021-12-12.
//

import UIKit

protocol ColorGettable {
    
    func uiColor() -> UIColor
    func cgColor() -> CGColor
    func rgba() -> RGBA
    func hsba() -> HSBA
    
}


