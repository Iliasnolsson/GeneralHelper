//
//  File.swift
//  
//
//  Created by Ilias Nikolaidis Olsson on 2022-08-02.
//

import UIKit

public extension UIUserInterfaceStyle {
    
    static var current: UIUserInterfaceStyle? {
        if let window = UIApplication.currentWindow {
            return window.traitCollection.userInterfaceStyle
        }
        return nil
    }
    
}
