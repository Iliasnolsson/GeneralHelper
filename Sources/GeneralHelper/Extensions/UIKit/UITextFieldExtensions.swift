//
//  UITextFieldExtensions.swift
//  Lotte
//
//  Created by Ilias Nikolaidis Olsson on 2022-01-01.
//

import UIKit

extension UITextField {
    
    var selectedTextIndex: Int? {
        get {
            if let selectedRange = selectedTextRange, isFirstResponder {
                if selectedRange.start == selectedRange.end {
                    return offset(from: beginningOfDocument, to: selectedRange.start)
                }
            }
            return nil
        }
        set {
            if isFirstResponder {
                if let selectedTextIndex = newValue {
                    if let position = position(from: beginningOfDocument, offset: selectedTextIndex) {
                        selectedTextRange = textRange(from: position, to: position)
                    }
                } else {
                    resignFirstResponder()
                }
            }
        }
    }
    
    var selectedTextIndexRange: ClosedRange<Int>? {
        get {
            if let selectedRange = selectedTextRange, isFirstResponder {
                if selectedRange.start != selectedRange.end {
                    let fromIndex = offset(from: beginningOfDocument, to: selectedRange.start)
                    let toIndex = offset(from: beginningOfDocument, to: selectedRange.end)
                    return fromIndex...toIndex
                }
            }
            return nil
        }
        set {
            if isFirstResponder {
                if let newRange = newValue {
                    if let fromPosition = position(from: beginningOfDocument, offset: newRange.lowerBound), let toPosition = position(from: beginningOfDocument, offset: newRange.upperBound) {
                        selectedTextRange = textRange(from: fromPosition, to: toPosition)
                    }
                } else {
                    resignFirstResponder()
                }
            }
        }
    }
    
}
