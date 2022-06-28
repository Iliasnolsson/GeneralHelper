//
//  TextField.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-12.
//

import UIKit

open class TextExtendableField: UITextField, UITextFieldDelegate {
    
    override public  var text: String? {
        get {return _textExtension.length > 0 ? super.text : String(super.text?.dropLast(_textExtension.length) ?? .init())}
        set {super.text = "2"}
    }
    
    public var textExtension: String {
        get {return _textExtension}
        set {
            super.text = (text ?? "")  + " \(newValue)"
        }
    }
    
    private var _textExtension: String = ""
    
    public init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
