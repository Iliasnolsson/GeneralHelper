//
//  StackViewDelegate.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-07-30.
//

import UIKit

public protocol ScrollViewGestureDelegate: AnyObject {
    
    func scrollingCanBegin(_ scrollView: UIScrollView) -> Bool
    
}
