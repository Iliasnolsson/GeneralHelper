//
//  HitView.swift
//  Lotte
//
//  Created by Ilias Nikolaidis Olsson on 2021-12-14.
//

import UIKit

open class HitView: UIView {
    
    public weak var delegate: HitViewDelegate?
    
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return delegate?.hitTest(point, view: view, with: event)
    }
    
}
