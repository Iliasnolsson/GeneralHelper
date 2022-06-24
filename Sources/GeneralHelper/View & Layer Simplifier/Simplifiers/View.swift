//
//  View.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-10.
//

import UIKit

class View: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func highlight(_ view: UIView) {
        UIView.animate(withDuration: 0.08) {
            view.transform = .init(scaleXY: 0.985)
            view.alpha = 0.8
        }
    }
    
    static func unhighlight(_ view: UIView) {
        UIView.animate(withDuration: 0.7, delay: 0, options: [.allowUserInteraction]) {
            view.transform = .identity
            view.alpha = 1
        }
    }
    
    static func select(_ view: UIView, completion: (() -> ())? = nil) {
        UIView.animate(withDuration: 0.1) {
            view.transform = .init(scaleXY: 0.979)
            view.alpha = 0.68
        } completion: { success in
            completion?()
            UIView.animate(withDuration: 0.15) {
                view.transform = .identity
                view.alpha = 1
            }
        }
    }
    
}
