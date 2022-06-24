//
//  UIViewControllerExtensions.swift
//  Lotte
//
//  Created by Ilias Nikolaidis Olsson on 2021-12-28.
//

import UIKit

extension UIViewController {
    
    func setNavigationBarContraintsView(_ constraintsView: UIView, alignment: SideOrCenterHorizontal) {
        constraintsView.translatesAutoresizingMaskIntoConstraints = false
        let height = constraintsView.heightAnchor.constraint(equalToConstant: 3000)
        let width = constraintsView.widthAnchor.constraint(equalToConstant: 3000)
        height.priority = .init(rawValue: 850)
        width.priority = .init(rawValue: 850)
        height.isActive = true
        width.isActive = true
        switch alignment {
        case .left:
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: constraintsView)
        case .center:
            navigationItem.titleView = constraintsView
        case .right:
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: constraintsView) 
        }
    }
    
}
