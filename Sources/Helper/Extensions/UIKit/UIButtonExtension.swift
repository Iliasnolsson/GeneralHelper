//
//  UIButtonExtension.swift
//  UIButtonExtension
//
//  Created by Ilias Nikolaidis Olsson on 2021-08-18.
//

import UIKit

@available(iOS 15, *)
extension UIButton {
    
    var cornerStyle: UIButton.Configuration.CornerStyle? {
        get {configuration?.cornerStyle}
        set {
            setConfigurationIfNeeded()
            configuration?.cornerStyle = newValue ?? .fixed
        }
    }
    
    
    var leftPadding: CGFloat {
        get {
            setConfigurationIfNeeded()
            return configuration!.contentInsets.trailing
        }
        set {
            setConfigurationIfNeeded()
            configuration?.contentInsets.leading = newValue
        }
    }
    var rightPadding: CGFloat {
        get {
            setConfigurationIfNeeded()
            return configuration!.contentInsets.trailing
        }
        set {
            setConfigurationIfNeeded()
            configuration?.contentInsets.trailing = newValue
        }
    }
    var topPadding: CGFloat {
        get {
            setConfigurationIfNeeded()
            return configuration!.contentInsets.top
        }
        set {
            setConfigurationIfNeeded()
            configuration?.contentInsets.top = newValue
        }
    }
    var bottomPadding: CGFloat {
        get {
            setConfigurationIfNeeded()
            return configuration!.contentInsets.bottom
        }
        set {
            setConfigurationIfNeeded()
            configuration?.contentInsets.bottom = newValue
        }
    }
    
    func setPadding(increaseCurrentBy padding: CGFloat) {
        setConfigurationIfNeeded()
        let oldInset = configuration?.contentInsets ?? .zero
        configuration?.contentInsets = .init(top: oldInset.top + padding, leading: oldInset.leading + padding, bottom: oldInset.bottom + padding, trailing: oldInset.trailing + padding)
    }
    
    
    
    /// The distance between the title and subtitle labels.
    var titlePadding: CGFloat {
        get {configuration?.titlePadding ?? 0}
        set {
            setConfigurationIfNeeded()
            configuration?.titlePadding = newValue
        }
    }

    var titleAlignment: UIButton.Configuration.TitleAlignment {
        get {configuration?.titleAlignment ?? .leading}
        set {
            setConfigurationIfNeeded()
            configuration?.titleAlignment = newValue
        }
    }
    /// The distance between the button’s image and text.
    var imagePadding: CGFloat {
        get {configuration?.imagePadding ?? 0}
        set {
            setConfigurationIfNeeded()
            configuration?.imagePadding = newValue
        }
    }
    var imagePlacement: NSDirectionalRectEdge {
        get {configuration?.imagePlacement ?? .leading}
        set {
            setConfigurationIfNeeded()
            configuration?.imagePlacement = newValue
        }
    }
    
    
    var title: String? {
        get {configuration?.title}
        set {
            setConfigurationIfNeeded()
            configuration?.title = newValue
        }
    }
    

    var subtitle: String? {
        get {configuration?.subtitle}
        set {
            setConfigurationIfNeeded()
            configuration?.subtitle = newValue
        }
    }
    
    var attributedTitle: AttributedString? {
        get {configuration?.attributedTitle}
        set {
            setConfigurationIfNeeded()
            configuration?.attributedTitle = newValue
        }
    }
    var attributedSubtitle: AttributedString? {
        get {configuration?.attributedSubtitle}
        set {
            setConfigurationIfNeeded()
            configuration?.attributedSubtitle = newValue
        }
    }
    
    
    var image: UIImage? {
        get {configuration?.image}
        set {
            setConfigurationIfNeeded()
            configuration?.image = newValue
        }
    }
    var foregroundColor: UIColor? {
        get {configuration?.baseForegroundColor}
        set {
            setConfigurationIfNeeded()
            configuration?.baseForegroundColor = newValue
        }
    }
    
     
    private func setConfigurationIfNeeded() {
        if configuration == nil {configuration = .plain()}
    }
    
    
    func setText(_ text: String?, for state: UIControl.State) {
        setText(text, attributes: [:], for: state)
        
        
    }
    
    func setText(_ text: String?, attributes: [NSAttributedString.Key : Any], for state: UIControl.State) {
        setText(text, attributes: attributes, spacingFraction: UILabel.textSpacingFractionDefault, for: state)
    }
    
    func setText(_ newText: String?, attributes: [NSAttributedString.Key : Any], spacingFraction: CGFloat, for state: UIControl.State) {
        var attributes = attributes
        attributes[.kern] = Label.spacing(forFraction: spacingFraction, pointSize: (attributes[.font] as? UIFont)?.pointSize ?? titleLabel?.font.pointSize ?? 10)
        setAttributedTitle(.init(string: newText ?? "", attributes: attributes), for: state)
    }
    
}
