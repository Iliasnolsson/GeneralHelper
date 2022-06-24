//
//  ScrollView.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-18.
//

import UIKit

class ScrollView: UIScrollView {
    
    weak var gestureDelegate: ScrollViewGestureDelegate?
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.panGestureRecognizer  {
            return gestureDelegate?.scrollingCanBegin(self) ?? true
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


