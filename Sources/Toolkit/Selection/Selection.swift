//
//  Selection.swift
//  secret-project
//
//  Created by Ilias Nikolaidis Olsson on 2022-10-27.
//

import Foundation

public class Selection<Element> {
    
    let primary: Element
    let secondaries: [Element]
    
    public init(primary: Element, secondaries: [Element]) {
        self.primary = primary
        self.secondaries = secondaries
    }
    
    public init(_ primary: Element) {
        self.primary = primary
        self.secondaries = []
    }
    
    public init(_ selection: Selection<Element>) {
        self.primary = selection.primary
        self.secondaries = selection.secondaries
    }
    
    public convenience init?(array: [Element]) {
        var mutableArray = array
        if let first = mutableArray.first {
            mutableArray.removeFirst()
            self.init(primary: first, secondaries: mutableArray)
            return
        }
        return nil
    }
}

// MARK: Helpers
public extension Selection {
    
    func array() -> [Element] {
        return [primary] + secondaries
    }
    
    func flatArray<InnerElement>() -> [InnerElement] where Element == Array<InnerElement> {
        return ([primary] + secondaries).flatMap({$0})
    }
    
    func codable() -> CodableSelection<Element> where Element: Codable {
        return .init(primary: primary, secondaries: secondaries)
    }
    
}

public extension Array {
    
    func selection() -> Selection<Element>? {
        return .init(array: self)
    }
    
}

// MARK: Map
public extension Selection {
    
    func map<OtherElement, ElementOfResult>(with otherSelection: Selection<OtherElement>, _ expression: (Element, OtherElement) throws -> ElementOfResult) rethrows -> Selection<ElementOfResult> {
        let newPrimary = try expression(primary, otherSelection.primary)
        var newSecondaries = [ElementOfResult]()
        for index in secondaries.indices {
            let secondary = secondaries[index]
            let otherSecondary = otherSelection.secondaries[index]
            newSecondaries.append(try expression(secondary, otherSecondary))
        }
        return .init(primary: newPrimary, secondaries: newSecondaries)
    }
    
    func map<ElementOfResult>(_ expression: ((Element) throws -> ElementOfResult)) rethrows -> Selection<ElementOfResult> {
        return .init(primary: try expression(primary),
                     secondaries: try secondaries.map(expression))
    }
    
    func compactMap<ElementOfResult>(_ expression: ((Element) throws -> ElementOfResult?)) rethrows -> Selection<ElementOfResult>? {
        if let primaryMapped = try expression(primary) {
            let secondariesMapped = try secondaries.compactMap(expression)
            if secondariesMapped.count == secondaries.count {
                return .init(primary: primaryMapped,
                             secondaries: secondariesMapped)
            }
        }
        return nil
    }
    
}

// MARK: ForEach
public extension Selection {
    
    func forEach<OtherElement>(with otherSelection: Selection<OtherElement>, _ expression: (Element, OtherElement) throws -> Void) rethrows {
        try expression(primary, otherSelection.primary)
        for index in secondaries.indices {
            let secondary = secondaries[index]
            let otherSecondary = otherSelection.secondaries[index]
            try expression(secondary, otherSecondary)
        }
    }
    
    func forEach(_ expression: (Element) throws -> Void) rethrows {
        try expression(primary)
        try secondaries.forEach(expression)
    }
    
}

// MARK: All Satisfy
public extension Selection {
    
    func allSatisfy(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
        return try (predicate(primary) && secondaries.allSatisfy(predicate))
    }
    
    func allEqualsSameValue<T: Equatable>(_ getValue: ((_ element: Element) -> T)) -> Bool {
        let primaryValue = getValue(primary)
        return secondaries.allSatisfy({getValue($0) == primaryValue})
    }
    
}

// MARK: Max/Min
public extension Selection {
    
    func min(by expression: (Element, Element) throws -> Bool) rethrows -> Element {
        if let minSecondary = try secondaries.min(by: expression) {
            return try expression(primary, minSecondary) ? primary : minSecondary
        }
        return primary
    }
    
    func max(by expression: (Element, Element) throws -> Bool) rethrows -> Element {
        if let maxSecondary = try secondaries.max(by: expression) {
            return try expression(primary, maxSecondary) ? maxSecondary : primary
        }
        return primary
    }
    
}
