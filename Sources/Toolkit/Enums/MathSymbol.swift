//
//  MathSymbol.swift
//  old-version-of-secret-project
//
//  Created by Ilias Nikolaidis Olsson on 2022-01-19.
//

import Foundation

public enum MathSymbol {
    case divide
    case multiply
    case subtract
    case add
    
    public init?(character: Character) {
        switch character {
        case "÷":
            self = .divide
        case "×":
            self = .multiply
        case "−":
            self = .subtract
        case "+":
            self = .add
        default:
            return nil
        }
    }
    
}

public extension MathSymbol {
    
    var characterString: String {
        return String(character)
    }
    
    var character: Character {
        switch self {
        case .divide:
            return "÷"
        case .multiply:
            return "×"
        case .subtract:
            return "−"
        case .add:
            return "+"
        }
    }
    
    var characterSymbolName: String {
        switch self {
        case .divide:
            return "divide"
        case .multiply:
            return "multiply"
        case .subtract:
            return "subtract"
        case .add:
            return "addition"
        }
    }
    
}
