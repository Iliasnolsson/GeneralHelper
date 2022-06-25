//
//  SizeableNavigationBar.swift
//  Lotte
//
//  Created by Ilias Nikolaidis Olsson on 2021-12-28.
//

import UIKit

public class NavigationBar: UINavigationBar {
    
    public var heightAddon: CGFloat = 0
    
    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        if heightAddon == 0 {return super.sizeThatFits(size)}
        return .init(width: super.sizeThatFits(size).width, height: getDefualtHeight() + heightAddon)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if heightAddon == 0 {return}
        let height = getDefualtHeight() + heightAddon
        frame = CGRect(x: frame.origin.x, y: 0, width: frame.size.width, height: height - safeAreaInsets.top)
        for subview in self.subviews {
            let stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarBackground") {
                subview.frame = CGRect(x: 0, y: 0, width: frame.width, height: height)
                subview.backgroundColor = backgroundColor
            } else if stringFromClass.contains("BarContent") {
                let y = (heightAddon / 2) + safeAreaInsets.top
                subview.frame = CGRect(x: subview.frame.origin.x, y: y, width: subview.frame.width, height: height - y)
                subview.backgroundColor = backgroundColor
            }
        }
    }

    public func getDefualtHeight() -> CGFloat {
        return UINavigationController().navigationBar.frame.size.height + safeAreaInsets.top
    }
    
}
