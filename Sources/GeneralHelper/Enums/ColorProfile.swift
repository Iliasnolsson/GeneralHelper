//
//  ColorProfile.swift
//  ColorProfile
//
//  Created by Ilias Nikolaidis Olsson on 2021-08-15.
//

import QuartzCore

enum ColorProfile: String, Codable {
    case sRGB = "s"
    case adobeRGB1998 = "a"
    
    var title: String {
        switch self {
        case .adobeRGB1998:
            return "Adobe RGB"
        default:
            return String(describing: self)
        }
    }
    
    var colorSpace: CGColorSpace? {
        return .init(name: colorSpaceName)
    }
    
    var colorSpaceName: CFString {
        switch self {
        case .sRGB:
            return CGColorSpace.sRGB
        case .adobeRGB1998:
            return CGColorSpace.adobeRGB1998
        }
    }
    
    static var allCases: [ColorProfile] {[.sRGB, .adobeRGB1998]}
    
}
