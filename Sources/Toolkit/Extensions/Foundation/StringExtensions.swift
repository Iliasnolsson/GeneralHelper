//
//  String.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-10.
//

import UIKit

public extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}

public extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}


// MARK: To Image
public extension String {
    
    func toImage(fontSize: CGFloat) -> UIImage? {
        let nsString = (self as NSString)
        let font = UIFont.systemFont(ofSize: fontSize)
        let stringAttributes = [NSAttributedString.Key.font: font]
        let imageSize = nsString.size(withAttributes: stringAttributes)

        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        UIColor.clear.set()
        UIRectFill(CGRect(origin: CGPoint(), size: imageSize))
        nsString.draw(at: CGPoint.zero, withAttributes: stringAttributes)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
    
}

// MARK: Number Spacings
public extension String {
    
    func insertSpacingInNumbers() -> String {
        return insertSpacingInNumbersInternal(selectedIndex: nil).text
    }
    func insertSpacingInNumbers(selectedIndex: Int) -> (text: String, selectedIndex: Int) {
        let (text, newSelectedIndex) = insertSpacingInNumbersInternal(selectedIndex: selectedIndex)
        return (text, newSelectedIndex!)
    }
    func removeSpacingInNumbers() -> String {
        return removeSpacingInNumbersInternal(selectedIndex: nil).text
    }
    func removeSpacingInNumbers(selectedIndex: Int) -> (text: String, selectedIndex: Int) {
        let (text, newSelectedIndex) = removeSpacingInNumbersInternal(selectedIndex: selectedIndex)
        return (text, newSelectedIndex!)
    }
    
    private func insertSpacingInNumbersInternal(selectedIndex: Int? = nil) -> (text: String, selectedIndex: Int?) {
        var result = ""
        let components = splitWhereNumber()
        var newSelectedIndex = selectedIndex
        
        for (textIsNumber, text) in components {
            var text = text
            if textIsNumber {
                var numberOfZerosAtStart: Int = 0
                if text != "0" {
                    for char in text {
                        if char == "0" {
                            numberOfZerosAtStart += 1
                        } else {break}
                    }
                    if numberOfZerosAtStart > 0 {
                        text.removeSubrange(startIndex..<text.index(text.startIndex, offsetBy: numberOfZerosAtStart))
                        text.insert(contentsOf: Array(repeating: "1", count: numberOfZerosAtStart), at: text.startIndex)
                    }
                }
                text = text.replacingOccurrences(of: ",", with: ".")
                var textFromDecimalToEnd = ""
                if let decimalIndex = text.firstIndex(of: ".") {
                    textFromDecimalToEnd = String(text[decimalIndex..<text.endIndex])
                    text.removeSubrange(decimalIndex..<text.endIndex)
                    textFromDecimalToEnd = textFromDecimalToEnd.replacingOccurrences(of: ".", with: ",")
                }
                if let textAsDecimal = Decimal(string: text) {
                    var textWithSpacings = textAsDecimal.formattedWithSeparator
                    textWithSpacings = textWithSpacings.replacingOccurrences(of: ".", with: ",")
                    if var oldSelectedIndex = newSelectedIndex {
                        let textIndiciesOfInsertions = textWithSpacings.indicies(forCharactersWhere: {$0 == " "}).map({text.distance(from: text.startIndex, to: $0)})
                        for insertionIndex in textIndiciesOfInsertions.map({$0 + result.count}) {
                            if oldSelectedIndex > insertionIndex {
                                oldSelectedIndex += 1
                            }
                        }
                        newSelectedIndex = oldSelectedIndex
                    }
                    var zerosToInsert = numberOfZerosAtStart
                    var charIndexToReplace = 0
                    while zerosToInsert != 0 {
                        let charStringIndexToReplace = textWithSpacings.index(textWithSpacings.startIndex, offsetBy: charIndexToReplace)
                        if textWithSpacings[charStringIndexToReplace].isWhitespace == false {
                            zerosToInsert -= 1
                            textWithSpacings.remove(at: charStringIndexToReplace)
                            textWithSpacings.insert("0", at: text.index(text.startIndex, offsetBy: charIndexToReplace))
                        }
                        charIndexToReplace += 1
                    }
                    result.append(textWithSpacings + textFromDecimalToEnd)
                }
            } else {
                result.append(text)
            }
        }
        return (result, newSelectedIndex)
    }
    
    private func removeSpacingInNumbersInternal(selectedIndex: Int? = nil) -> (text: String, selectedIndex: Int?) {
        var result = ""
        let components = splitWhereNumber()
        var newSelectedIndex = selectedIndex
        for (textIsNumber, text) in components {
            if textIsNumber {
                if var oldSelectedIndex = newSelectedIndex {
                    let textIndiciesGettingRemoved = text.indicies(forCharactersWhere: {$0 == " "}).map({text.distance(from: text.startIndex, to: $0)})
                    for indexRemoved in textIndiciesGettingRemoved.map({$0 + result.count}) {
                        if indexRemoved < oldSelectedIndex {
                            oldSelectedIndex -= 1
                        }
                    }
                    newSelectedIndex = oldSelectedIndex
                }
                result.append(text.replacingOccurrences(of: " ", with: ""))
            } else {
                result.append(text)
            }
        }
        return (result, newSelectedIndex)
    }

    func splitWhereNumber() -> [(isNumber: Bool, text: String)] {
        if isEmpty {return []}
        var components = [(isNumber: Bool, text: String)] ()
        var currentComponentFromIndex = 0
        var isCurrentComponentNumber = first!.isNumber
        for charIndex in 0..<length {
            let character = self[index(startIndex, offsetBy: charIndex)]
            let characterQualifyAsNumber = (character.isNumber || character == "," || character == "." || character == " ") && !(character == "²" || character == "³")
            if characterQualifyAsNumber != isCurrentComponentNumber {
                components.append((isCurrentComponentNumber, self[currentComponentFromIndex..<charIndex]))
                currentComponentFromIndex = charIndex
                isCurrentComponentNumber = characterQualifyAsNumber
                if charIndex == length - 1 {
                    components.append((isCurrentComponentNumber, self[currentComponentFromIndex..<length]))
                }
            } else if charIndex == length - 1 {
                components.append((isCurrentComponentNumber, self[currentComponentFromIndex..<length]))
            }
        }
        return components
    }
    
}

// MARK: Stylized to Calculatable, Calculatable to Stylized
public extension String {
    
    func calculatableStylized(maxNumberOfDecimals: Int? = nil) -> String? {
        var result = self
        result = result.replacingOccurrences(of: "**2.0", with: "²")
        result = result.replacingOccurrences(of: "**3.0", with: "³")
        result = result.replacingOccurrences(of: "sqrt", with: "√")
        
        for index in (0..<result.length).reversed() {
            let indexAfter = index + 1
            if index <= result.length - 1 {
                let character = Character(result[index])
                
                if indexAfter <= result.length - 1 {
                    let characterAfter = result[indexAfter]
                    if character == "*" && characterAfter == "*" {
                        let equationToIndex = index - 1
                        var equationFromIndex = equationToIndex
                        var numberOfRightBrackets: Int = 0
                        for equationIndex in (0..<equationToIndex).reversed() {
                            let equationCharacter = result[equationIndex]
                            if equationCharacter == "(" {
                                if numberOfRightBrackets == 0 {
                                    equationFromIndex = equationIndex + 1
                                    break
                                }
                                numberOfRightBrackets -= 1
                            } else if equationCharacter == ")" {
                                numberOfRightBrackets += 1
                            }
                        }
                        let equationText = result[equationFromIndex..<equationToIndex]
                        let totalFromIndex = result.index(result.startIndex, offsetBy: equationFromIndex - 2)
                        let totalToIndex = result.index(result.startIndex, offsetBy: equationToIndex + 12)
                        
                        result.removeSubrange(totalFromIndex...totalToIndex)
                        let insertIndex = result.index(result.startIndex, offsetBy: equationFromIndex - 2)
                        result.insert(contentsOf: "∛(" + equationText + ")", at: insertIndex)
                    }
                }
            }
        }
        
        result.replaceAll(ofCharacter: "-", with: "−")
        result.replaceAll(ofCharacter: "*", with:"×")
        result.replaceAll(ofCharacter: "/", with: "÷")
        result.replaceAll(ofCharacter: ".", with: ",")
        
        if let lastCharacter = result.last, MathSymbol(character: lastCharacter) != nil || lastCharacter == "." {
            result.removeLast()
        }
        
        let leftBracketIndicies = indicies(forCharactersWhere: {$0 == "("})
        let rightBracketIndicies = indicies(forCharactersWhere: {$0 == ")"})
        if leftBracketIndicies.count > rightBracketIndicies.count {
            let numberRightBracketsToAdd = leftBracketIndicies.count - rightBracketIndicies.count
            let textsToAdd = Array(repeating: ")", count: numberRightBracketsToAdd)
            textsToAdd.forEach {result.append(contentsOf: $0)}
        } else if rightBracketIndicies.count > leftBracketIndicies.count {
            let numberLeftBracketsToAdd = rightBracketIndicies.count - leftBracketIndicies.count
            let textsToAdd = Array(repeating: "(", count: numberLeftBracketsToAdd)
            textsToAdd.forEach {result = $0 + result}
        }
        if result.contains("()") {
            return nil
        }
        if result == "" {
            return "0"
        }
        for index in (0..<result.length).reversed() {
            if index == 0 {break}
            if let numberSubtring = result.numberSubstring(atIndex: index) {
                var substring = numberSubtring.substring
                let range = numberSubtring.range
                if substring.contains(",") {
                    substring = substring.replacingOccurrences(of: ",", with: ".")
                    if let number = Double(substring) {
                        let numberFloat = CGFloat(number)
                        let numberOfDecimals = numberFloat.numberOfDecimals()
                        let newNumberText = numberFloat.string(withDecimals: maxNumberOfDecimals != nil ? min(maxNumberOfDecimals!, numberOfDecimals) : numberOfDecimals).replacingOccurrences(of: ".", with: ",")
                        let fromIndex = result.index(result.startIndex, offsetBy: range.lowerBound)
                        let toIndex = result.index(result.startIndex, offsetBy: range.upperBound)
                        result.removeSubrange(fromIndex..<toIndex)
                        result.insert(contentsOf: newNumberText, at: result.index(result.startIndex, offsetBy: range.lowerBound))
                    }
                }
            }
        }
        return result
    }
    
    func calculatable() -> String? {
        var result = self
        for index in (0..<result.length).reversed() {
            if let (substring, range) = result.numberSubstring(atIndex: index) {
                if substring.contains(where: {$0 == "," || $0 == "."}) == false {
                    result.insert(contentsOf: ".0", at: result.index(result.startIndex, offsetBy: range.upperBound))
                }
            }
        }
        if let first = result.first {
            if let mathSymbol = MathSymbol(character: first), mathSymbol != .subtract {
                result.removeFirst()
            }
            if let specialSymbol = SpecialMathSymbol(character: first), specialSymbol.isPowerOfSomthing {
                result.removeFirst()
            }
        }
        if let last = result.last, MathSymbol(character: last) != nil {
            result.removeLast()
        }
        
        func makeProofable() {
            for index in (0..<result.length).reversed() {
                if index == 0 {break}
                let indexAfter = index + 1
                let character = Character(result[index])
                var shouldRemove = false
                
                if indexAfter <= result.length - 1 {
                    let characterAfter = Character(result[indexAfter])
                    if MathSymbol(character: character) != nil {
                        if characterAfter == ")" {
                            shouldRemove = true
                        }
                        if SpecialMathSymbol(string: characterAfter.description)?.isPowerOfSomthing ?? false {
                            shouldRemove = true
                        }
                    } else if character == "," || character == "." {
                        if !characterAfter.isNumber {
                            shouldRemove = true
                        }
                    }
                }
                if shouldRemove {
                    result.remove(at: result.index(result.startIndex, offsetBy: index))
                    makeProofable()
                }
            }
        }
        makeProofable()
        
        result.replaceAll(ofCharacter: "−", with: "-")
        result.replaceAll(ofCharacter: "×", with: "*")
        result.replaceAll(ofCharacter: "÷", with: "/")
        result.replaceAll(ofCharacter: ",", with: ".")
        result = result.replacingOccurrences(of: "²", with: "**2.0")
        result = result.replacingOccurrences(of: "³", with: "**3.0")
        result = result.replacingOccurrences(of: "√", with: "sqrt")
        
        if let lastCharacter = result.last, MathSymbol(character: lastCharacter) != nil || lastCharacter == "." {
            result.removeLast()
        }
        
        let leftBracketIndicies = result.indicies(forCharactersWhere: {$0 == "("})
        let rightBracketIndicies = result.indicies(forCharactersWhere: {$0 == ")"})
        if leftBracketIndicies.count > rightBracketIndicies.count {
            let numberRightBracketsToAdd = leftBracketIndicies.count - rightBracketIndicies.count
            let textsToAdd = Array(repeating: ")", count: numberRightBracketsToAdd)
            textsToAdd.forEach {result.append(contentsOf: $0)}
        } else if rightBracketIndicies.count > leftBracketIndicies.count {
            let numberLeftBracketsToAdd = rightBracketIndicies.count - leftBracketIndicies.count
            let textsToAdd = Array(repeating: "(", count: numberLeftBracketsToAdd)
            textsToAdd.forEach {result = $0 + result}
        }
        if result.contains("()") {
            return nil
        }
        if result == "" {
            return "0"
        }
        for index in (0..<result.length).reversed() {
            let indexAfter = index + 1
            let character = Character(result[index])
            
            if indexAfter <= result.length - 2 {
                if character == "∛" {
                    let equationFromIndex = indexAfter + 1
                    var equationToIndex = equationFromIndex
                    var numberOfLeftBrackets: Int = 0
                    for equationIndex in equationFromIndex..<result.length {
                        let equationCharacter = result[equationIndex]
                        if equationCharacter == ")" {
                            if numberOfLeftBrackets == 0 {
                                equationToIndex = equationIndex
                                break
                            }
                            numberOfLeftBrackets -= 1
                        } else if equationCharacter == "(" {
                            numberOfLeftBrackets += 1
                        }
                    }
                    let equationText = result[equationFromIndex..<equationToIndex]
                    let totalFromIndex = result.index(result.startIndex, offsetBy: equationFromIndex - 2)
                    let totalToIndex = result.index(result.startIndex, offsetBy: equationToIndex)
                    result.removeSubrange(totalFromIndex...totalToIndex)
                    let insertIndex = result.index(result.startIndex, offsetBy: equationFromIndex - 2)
                    result.insert(contentsOf: "((" + equationText + ")" + "**(1.0/3.0))", at: insertIndex)
                }
            }
        }
        return result
    }
    
    
    func numberSubstring(atIndex index: Int, allowDecmials: Bool = true) -> (substring: String, range: Range<Int>)? {
        if index >= 0 && index < length {
            let character = self[self.index(startIndex, offsetBy: index)]
            if !character.isNumber {
                return nil
            }
        }
        var upperBound = length
        var lowerBound = 0
        
        if index <= length {
            for i in index..<length {
                let character = Character(self[i])
                if (SpecialMathSymbol(string: character.description)?.isPowerOfSomthing ?? false) || (character.isNumber || (allowDecmials && (character == "." || character == ","))) == false {
                    upperBound = i
                    break
                }
            }
        }
    
        if index <= length {
            for i in (0..<index).reversed() {
                let character = Character(self[i])
                if (SpecialMathSymbol(character: character)?.isPowerOfSomthing ?? false) || (character.isNumber || (allowDecmials && (character == "." || character == ","))) == false {
                    lowerBound = i + 1
                    break
                }
            }
        }
        if lowerBound == upperBound {return nil}
        let range = lowerBound..<upperBound
        let substring = self[range]
        
        return (substring, range)
    }
    
    func calculate() -> CGFloat? {
        guard let calculatable = calculatable() else {return nil}
        
        let mathExpression = NSExpression(format: calculatable)
        let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? CGFloat
        if let mathValue = mathValue {
            if mathValue.isInfinite || mathValue.isNaN {
                return nil
            }
        }
        return mathValue
    }
    
}

public extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    
    func indicies(forCharactersWhere closure: ((Character) -> (Bool))) -> [String.Index] {
        var foundIndicies = [String.Index]()
        for index in self.indices {
            let character = self[index]
            if closure(character) {
                foundIndicies.append(index)
            }
        }
        return foundIndicies
    }
    
    mutating func replaceAll(ofCharacter character: Character, with newCharacter: Character) {
        self = replacingOccurrences(of: String(character), with: String(newCharacter), options: NSString.CompareOptions.literal, range: nil)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    init(uniqueIn strings: [String]) {
        var builtString = ""
        while strings.contains(builtString) || builtString == "" {
            for char in "abcdefghijklmnopqrstuvwxyz123456789" {
                let charString = "\(builtString)\(char)"
                if !strings.contains(charString) {
                    self.init()
                    self = charString
                    return
                }
            }
            let longerStrings = strings.filter({$0.count >= builtString.count})
            let chars = longerStrings.map({$0[builtString.count]}).filter({$0 != ""})
            
            let uniqueChars = Array(Set(chars))
            
            let amountOfEach = uniqueChars.map({a in (a, chars.filter({$0 == a}).count)})
            let leastCommonChar = amountOfEach.min(by: {a, b in a.1 < b.1})?.0 ?? "a"
            
            builtString = "\(builtString)\(leastCommonChar)"
        }
        self.init()
        self = builtString
    }
    
    mutating func addIndexNumber() {
        if let fromIndex = self.lastIndex(of: " ") {
            let stringAfterIndex = self.substring(fromIndex: fromIndex.utf16Offset(in: self) + 1)
            if let number = Int(stringAfterIndex) {
                self = String(self.dropLast(stringAfterIndex.count + 1)) + " " + String(number + 1)
            }
        }
        self = self + " \(2)"
    }
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
}

public extension String {
    
    
    var cgColor: CGColor {
        let (red, green, blue) = hexColorComponents()
        
        if #available(iOS 13.0, tvOS 13.0, *) {
            return CGColor(red: red, green: green, blue: blue, alpha: 1)
        } else {
            return CGColor(
                colorSpace: CGColorSpaceCreateDeviceRGB(),
                components: [red, green, blue])!
        }
    }
    
    func hexColorComponents() -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var cString:String = trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return (red: 0, green: 0, blue: 0)
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return (red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0)
    }
    
}


extension String: Error {
    
}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}


public extension String {
    
    static func description(forTitleToMessageIn dict: [String : String], sameRow: Bool = false) -> String {
        var description = ""
        description.append("\r\n")
        if sameRow {
            for (title, message) in dict {
                description.append(title + message)
            }
        } else {
            for (title, message) in dict {
                description.append(title)
                description.append(message)
            }
        }
        return description
    }
    
    
}
