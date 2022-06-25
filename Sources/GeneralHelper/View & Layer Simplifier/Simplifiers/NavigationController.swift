//
//  BarHeightAdjustableNavigationController.swift
//  Lotte
//
//  Created by Ilias Nikolaidis Olsson on 2021-12-28.
//

import UIKit

public class NavigationController: UINavigationController {
    
    public var barHeightAddon: CGFloat = 0 {
        didSet {
            (navigationBar as? NavigationBar)?.heightAddon = barHeightAddon
            viewControllers.forEach {$0.additionalSafeAreaInsets.top = barHeightAddon}
        }
    }

    public init() {
        super.init(navigationBarClass: NavigationBar.self, toolbarClass: nil)
    }
    
    override public init(rootViewController: UIViewController) {
        super.init(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        viewControllers = [rootViewController]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
