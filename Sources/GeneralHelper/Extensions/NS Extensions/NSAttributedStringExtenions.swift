//
//  NSAttributedStringExtenions.swift
//  NSAttributedStringExtenions
//
//  Created by Ilias Nikolaidis Olsson on 2021-08-18.
//

import UIKit

extension Dictionary where Key == NSAttributedString.Key, Value: Any {
    
    func withDefaultSpacing(font: UIFont) -> [Key : Value] {
        var attributes = self
        attributes[.kern] = (Label.spacing(forFraction: UILabel.textSpacingFractionDefault, pointSize: font.pointSize) as! Value)
        return attributes
    }
    
    func withSpacing(forFractionOfDefaultSpacing fraction: CGFloat, font: UIFont) -> [Key : Value] {
        var attributes = self
        attributes[.kern] = (Label.spacing(forFraction: fraction, pointSize: font.pointSize) as! Value)
        return attributes
    }
    
}

extension NSAttributedString {
    
    func withForegroundColor(_ newColor: UIColor?, forWord word: String) -> NSAttributedString {
        if string.isEmpty {return self}
        let mutable = NSMutableAttributedString(attributedString: self)
        if mutable.mutableString.contains(word) {
            let range = mutable.mutableString.range(of: word)
            mutable.addAttribute(.foregroundColor, value: newColor as Any, range: range)
        }
        return mutable
    }
    
    func height(forWidth width: CGFloat) -> CGFloat {
        let str = self
        let ts = NSTextStorage(attributedString: str)

        let size = CGSize(width: width, height:CGFloat.greatestFiniteMagnitude)

        let tc = NSTextContainer(size: size)
        tc.lineFragmentPadding = 0.0

        let lm = NSLayoutManager()
        lm.addTextContainer(tc)

        ts.addLayoutManager(lm)
        lm.glyphRange(forBoundingRect: CGRect(origin: .zero, size: size), in: tc)

        let rect = lm.usedRect(for: tc)
        return rect.integral.size.height
    }
    
    convenience init(text: String, attributes: [Key : Any] = [:], withImage image: UIImage?, onSide side: SideHorizontal) {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image

        let attributedString = NSMutableAttributedString()
        if side == .left {
            attributedString.append(NSAttributedString(attachment: imageAttachment))
        }
        attributedString.append(.init(string: text, attributes: attributes))
        if side == .right {
            attributedString.append(NSAttributedString(attachment: imageAttachment))
        }
        self.init(attributedString: attributedString)
    }
    
    convenience init(text: String, attributes: [Key : Any] = [:], withSystemImage systemName: String, onSide side: SideHorizontal) {
        let color = (attributes[.foregroundColor] as? UIColor) ?? UIColor.label
        let pointSize = (attributes[.font] as? UIFont)?.pointSize ?? 12
        let image = UIImage.systemImage(name: systemName, color: color, pointSize: pointSize)
        self.init(text: text, attributes: attributes, withImage: image, onSide: side)
    }
    
}
