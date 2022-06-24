//
//  BarHeightAdjustableNavigationController.swift
//  Lotte
//
//  Created by Ilias Nikolaidis Olsson on 2021-12-28.
//

import UIKit

class NavigationController: UINavigationController {
    
    var barHeightAddon: CGFloat = 0 {
        didSet {
            (navigationBar as? NavigationBar)?.heightAddon = barHeightAddon
            viewControllers.forEach {$0.additionalSafeAreaInsets.top = barHeightAddon}
        }
    }

    init() {
        super.init(navigationBarClass: NavigationBar.self, toolbarClass: nil)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        viewControllers = [rootViewController]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
