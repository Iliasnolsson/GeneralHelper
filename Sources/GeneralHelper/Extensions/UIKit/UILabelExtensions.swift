//
//  UILabelExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-07-27.
//

import UIKit

extension UILabel {
    
    typealias TextAfterDelay = (text: String, delay: Double)
    typealias AttributedAfterDelay = (attributed: NSAttributedString, delay: Double)
    
    func textAnimate(toTextAfterDelay entries: [TextAfterDelay], completion: (() -> ())? = nil) {
        var entriesMutable = entries
        if !entriesMutable.isEmpty {
            let textAfterDelay = entriesMutable.removeFirst()
            Timer.scheduledTimer(withTimeInterval: textAfterDelay.delay, repeats: false) { [weak self] timer in
                guard let self = self else {return}
                self.text = textAfterDelay.text
                self.textAnimate(toTextAfterDelay: entriesMutable, completion: completion)
            }
        } else {
            completion?()
        }
    }
    
    func textAnimate(writingToText: String, duration: Double, customDelayBeforeIndex: [Int : Double] = [:], completion: (() -> ())? = nil) {
        if writingToText.isEmpty {return}
        let characterStrings = Array(writingToText).map({String($0)})
        var textAfterDelays = [TextAfterDelay]()
        
        let delay = duration / max(1, Double(characterStrings.count - 1))
        var baseString = ""
        for index in characterStrings.indices {
            let characterString = characterStrings[index]
            baseString += characterString
            textAfterDelays.append((baseString, customDelayBeforeIndex[index] ?? (index == 0 ? 0 : delay)))
        }
        textAnimate(toTextAfterDelay: textAfterDelays, completion: completion)
    }
    
    func attributedTextAnimate(toTextAfterDelay entries: [AttributedAfterDelay], completion: (() -> ())? = nil) {
        var entriesMutable = entries
        if !entriesMutable.isEmpty {
            let textAfterDelay = entriesMutable.removeFirst()
            Timer.scheduledTimer(withTimeInterval: textAfterDelay.delay, repeats: false) { [weak self] timer in
                guard let self = self else {return}
                self.attributedText = textAfterDelay.attributed
                self.attributedTextAnimate(toTextAfterDelay: entriesMutable, completion: completion)
            }
        } else {
            completion?()
        }
    }
    
}

extension UILabel {
    
    static var textSpacingFractionDefault: CGFloat = 0.876
    
    func setText(_ newText: String?) {
        setText(newText, attributes: [:])
    }
    
    func setText(_ newText: String?, attributes: [NSAttributedString.Key : Any]) {
        setText(newText, attributes: attributes, spacingFraction: UILabel.textSpacingFractionDefault)
    }
    
    func setText(_ newText: String?, attributes: [NSAttributedString.Key : Any] = [:], withImage image: UIImage?, onSide side: SideHorizontal) {
        let attributes = setAttributesSpacing(on: attributes, forSpacingFraction: UILabel.textSpacingFractionDefault)
        let newAttributedText = NSAttributedString(text: newText ?? "", attributes: attributes, withImage: image, onSide: side)
        text = newText
        attributedText = newAttributedText
    }
    
    func setText(_ newText: String?, attributes: [NSAttributedString.Key : Any], spacingFraction: CGFloat) {
        let attributes = setAttributesSpacing(on: attributes, forSpacingFraction: spacingFraction)
        text = newText
        attributedText = NSAttributedString(string: newText ?? "", attributes: attributes)
    }
    
    func setAttributesSpacing(on attributes: [NSAttributedString.Key : Any], forSpacingFraction spacingFraction: CGFloat) -> [NSAttributedString.Key : Any] {
        var attributes = attributes
        attributes[.kern] = Label.spacing(forFraction: spacingFraction, pointSize: (attributes[.font] as? UIFont)?.pointSize ?? font.pointSize)
        return attributes
    }
 
    
    
}
