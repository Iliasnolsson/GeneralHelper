//
//  File.swift
//  
//
//  Created by Ilias Nikolaidis Olsson on 2022-06-24.
//

import UIKit

public enum SpecialMathSymbol {
    case powerOfTwo
    case powerOfThree

    case squareRoot
    case cubeRoot

    case piConstant
    case eulersNumber
    
    case naturalLogarithm
    case logarithm

    case sine
    case cosine
    case tangent
}

public extension SpecialMathSymbol {
    
    init?(string: String) {
        if let character = string.first {
            if let symbol = SpecialMathSymbol(character: character) {
                self = symbol
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    init?(character: Character) {
        switch character {
        case "²":
            self = .powerOfTwo
        case "³":
            self = .powerOfThree
        case "√":
            self = .squareRoot
        case "∛":
            self = .cubeRoot
        case "π":
            self = .piConstant
        case "e":
            self = .eulersNumber
        default:
            return nil
        }
    }
    
    var isPowerOfSomthing: Bool {self == .powerOfThree || self == .powerOfTwo}
    var isRootOfSomthing: Bool {self == .squareRoot || self == .cubeRoot}
    
    var character: Character {
        switch self {
        case .powerOfTwo:
            return "²"
        case .powerOfThree:
            return "³"
        case .squareRoot:
            return "√"
        case .cubeRoot:
            return "∛"
        case .piConstant:
            return "π"
        case .eulersNumber:
            return "e"
        default:
            return "d"
        }
    }
    
    var isRequiringBrackets: Bool {
        switch self {
        case .powerOfTwo:
            return false
        case .powerOfThree:
            return false
        case .piConstant:
            return false
        case .eulersNumber:
            return false
        default:
            return true
        }
    }

    func image(ofPointSize pointSize: CGFloat) -> UIImage? {
        switch self {
        case .squareRoot:
            return .systemImage(name: "x.squareroot", pointSize: pointSize)
        default:
            if let symbolImageName = symbolImageName {
                return .symbolImage(name: symbolImageName, pointSize: pointSize)
            }
            return nil
        }
    }
    
    var symbolImageName: String? {
        switch self {
        case .powerOfTwo:
            return "power.of.two"
        case .powerOfThree:
            return "power.of.three"
        case .cubeRoot:
            return "cube.root"
        case .piConstant:
            return "pi"
        case .eulersNumber:
            return "e.constant"
        case .naturalLogarithm:
            return "ln"
        case .logarithm:
            return "log"
        case .sine:
            return "sin"
        case .cosine:
            return "cos"
        case .tangent:
            return "tan"
        default:
            return nil
        }
    }
    
    
}
