//
//  File.swift
//  
//
//  Created by Ilias Nikolaidis Olsson on 2022-08-02.
//

import UIKit

public extension UIApplication {
    
    static var currentViewController: UIViewController? {
        var vc = UIApplication.currentWindow?.rootViewController
        while vc?.presentedViewController != nil {
            vc = vc?.presentedViewController
        }
        return vc
    }
    
    static var currentWindow: UIWindow? {
        if #available(iOS 15.0, *) {
            return UIApplication.shared
                .connectedScenes.lazy
                .compactMap { $0.activationState == .foregroundActive ? ($0 as? UIWindowScene) : nil }
                .last(where: { $0.keyWindow != nil })?
                .keyWindow
        }
        return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }
}

