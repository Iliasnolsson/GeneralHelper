//
//  CGColorExtension.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-02-09.
//

import UIKit

extension CGColor: Color {
    
    public static func initalize(rgba: RGBA) -> CGColor {
        return CGColor.initalize(r: rgba.r, g: rgba.g, b: rgba.b, a: rgba.a, colorSpaceIdentifier: CGColorSpace.sRGB)
    }
    
    
    public func rgba() -> RGBA {
        return UIColor(cgColor: self).rgba()
    }
    
}
