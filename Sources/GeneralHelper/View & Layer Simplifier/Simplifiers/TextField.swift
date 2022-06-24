//
//  TextField.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-12.
//

import UIKit

class TextField: UITextField, UIGestureRecognizerDelegate {
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override var selectedTextRange: UITextRange? {
        get {super.selectedTextRange}
        set {
            if isTapImproved {
                if let value = newValue, Date.timeIntervalSinceReferenceDate - tapIntervalSince > 0.2 {
                    let index = offset(from: beginningOfDocument, to: value.end)
                    if index != tapPreviousCharacterIndex {
                        if tapPreviousCharacterIndex != tapPreviousPreviousCharacterIndex {
                            tapPreviousPreviousCharacterIndex = tapPreviousCharacterIndex
                        }
                        tapPreviousCharacterIndex = index
                    }
                }
            }
            super.selectedTextRange = newValue
        }
    }
    
    
    var onDoubleTapped: ((_ label: UITextField) -> Void)?
    var onCharacterTapped: ((_ label: UITextField, _ characterIndex: Int) -> Void)?
    
    private var tapGesture = UITapGestureRecognizer()
    private var tapIntervalSince: Double = Date.timeIntervalSinceReferenceDate
    private var tapPreviousPreviousCharacterIndex: Int?
    private var tapPreviousCharacterIndex: Int?
    private var doubleTapIntervalSince: Double = Date.timeIntervalSinceReferenceDate
    private var isTapImproved: Bool = false
    
    func improveTap() {
        isTapImproved = true
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        tapGesture.delegate = self
        addGestureRecognizer(tapGesture)
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if isTapImproved {
            if gestureRecognizer == tapGesture {
                return true
            }
            if gestureRecognizer as? UILongPressGestureRecognizer != nil {
                let intervalSince = Date.timeIntervalSinceReferenceDate
                if intervalSince - tapIntervalSince < 1 && tapIntervalSince != doubleTapIntervalSince {
                    return false
                }
                return true
            }
            return false
        }
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if isTapImproved {
            if gestureRecognizer as? UILongPressGestureRecognizer != nil && otherGestureRecognizer == tapGesture {
                return true
            }
            if gestureRecognizer == tapGesture && otherGestureRecognizer as? UILongPressGestureRecognizer != nil {
                return true
            }
        }
        return false
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return isTapImproved ? false : super.canPerformAction(action, withSender: sender)
    }
    
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        if isTapImproved {
            if range.start == range.end {
                return super.selectionRects(for: range)
            } else {
                selectedTextRange = textRange(from: range.end, to: range.end)
            }
            return []
        }
        return super.selectionRects(for: range)
    }

    override func caretRect(for position: UITextPosition) -> CGRect {
        if isTapImproved {
            if let range = selectedTextRange {
                if range.start == range.end {
                    return super.caretRect(for: position)
                }
            }
            return .zero
        }
        return super.caretRect(for: position)
    }
    
    @objc private func doubleTap(_ recognizer: UITapGestureRecognizer) {
        onDoubleTapped?(self)
    }
    
    @objc private func tap(_ recognizer: UITapGestureRecognizer) {
        // only detect taps in attributed text
        guard let attributedText = attributedText, recognizer.state == .ended else {
            return
        }
        let font = (font ?? .init())
        let intervalSince = Date.timeIntervalSinceReferenceDate
        if intervalSince - tapIntervalSince < 0.18 {
            let index = tapPreviousPreviousCharacterIndex ?? text?.length ?? 0
            onCharacterTapped?(self, index)

            tapPreviousCharacterIndex = tapPreviousPreviousCharacterIndex
            onDoubleTapped?(self)
            tapIntervalSince = intervalSince
            doubleTapIntervalSince = intervalSince
            return
        }
        tapIntervalSince = intervalSince
        
        // Configure NSTextContainer
        let textContainer = NSTextContainer(size: bounds.size)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = .byTruncatingHead
        textContainer.maximumNumberOfLines = 1
        
        // Configure NSLayoutManager and add the text container
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        
        // Configure NSTextStorage and apply the layout manager
        let textStorage = NSTextStorage(attributedString: attributedText)
        textStorage.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, attributedText.length))
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = {() -> NSTextAlignment in
            switch textAlignment {
            case .left:
                return .left
            case .natural:
                return .natural
            case .justified:
                return .justified
            case .center:
                return .center
            case .right:
                return .right
            default:
                return .natural
            }
        }()
        textStorage.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        textStorage.addLayoutManager(layoutManager)
        
        // get the tapped character location
        var locationOfTouchInLabel = recognizer.location(in: recognizer.view)
        
        // account for text alignment and insets
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        var alignmentOffset: CGFloat!
        switch textAlignment {
        case .left, .natural, .justified:
            alignmentOffset = 0.0
            locationOfTouchInLabel.x -= rightView?.bounds.width ?? 0
        case .center:
            alignmentOffset = 0.5
        case .right:
            alignmentOffset = 1.0
            locationOfTouchInLabel.x += rightView?.bounds.width ?? 0
        default:
            break
        }
        let xOffset = ((bounds.size.width - textBoundingBox.size.width) * alignmentOffset) - textBoundingBox.origin.x
        //let yOffset = ((bounds.size.height - textBoundingBox.size.height) * alignmentOffset) - textBoundingBox.origin.y
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - xOffset, y: textBoundingBox.midY)
        
        // figure out which character was tapped
        var characterTapped = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        let glyphBound = layoutManager.boundingRect(forGlyphRange: NSRange(location: characterTapped, length: 1), in: textContainer)
        let glyphFrame = CGRect(origin: layoutManager.location(forGlyphAt: characterTapped), size: glyphBound.size)
        
        if (locationOfTouchInLabel.x - glyphFrame.midX) > 0 {
            characterTapped += 1
        }
        tapPreviousPreviousCharacterIndex = tapPreviousCharacterIndex
        tapPreviousCharacterIndex = characterTapped
        onCharacterTapped?(self, characterTapped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



