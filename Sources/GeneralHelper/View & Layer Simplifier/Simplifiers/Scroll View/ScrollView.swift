//
//  ScrollView.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-18.
//

import UIKit

open class ScrollView: UIScrollView {
    
    public weak var gestureDelegate: ScrollViewGestureDelegate?
    
    public init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.panGestureRecognizer  {
            return gestureDelegate?.scrollingCanBegin(self) ?? true
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


