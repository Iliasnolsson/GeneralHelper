//
//  FloatTextFormatter.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-07-17.
//

import CoreGraphics

public struct FloatTextFormatter {
    
    private static var punctuation = "."
    private var formatter: (_ value: CGFloat, _ endsWithPunctuation: Bool) -> (String)
    
}


public extension FloatTextFormatter {
        
    init(addingWithoutSpacing stringToAdd: String, decimals: Int = 0) {
        formatter = {value, endsWithPunct in value.string(withDecimals: decimals) + (endsWithPunct ? FloatTextFormatter.punctuation : "") + stringToAdd}
    }
    
    init(adding stringToAdd: String, decimals: Int = 0) {
        formatter = {value, endsWithPunct in value.string(withDecimals: decimals) + (endsWithPunct ? FloatTextFormatter.punctuation : "") + " " + stringToAdd}
    }
    
    init(decimals: Int = 0) {
        formatter = {value, endsWithPunct in value.string(withDecimals: decimals) + (endsWithPunct ? FloatTextFormatter.punctuation : "")}
    }
    
    func format(_ value: CGFloat, endsWithPunctuation: Bool = false) -> String {
        return formatter(value, endsWithPunctuation)
    }
    
}
