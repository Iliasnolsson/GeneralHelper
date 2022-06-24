//
//  UIImageExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-13.
//

import UIKit

extension UIView {
    
    // Superviews ordered from the parent of this uiview to the highest superview
    var superviews: [UIView] {
        var collected = [UIView]()
        if let parent = superview {
            collected.append(parent)
            return parent.superviews
        }
        return collected
    }
    
    var allSubviews: [UIView] {
        var allSubs = [UIView]()
        for subview in subviews {
            allSubs.append(subview)
            allSubs.append(contentsOf: subview.allSubviews)
        }
        return allSubs
    }
    
    func setAnchorPoint(location newAnchorPoint: CGPoint) {
        let anchorTranslation = newAnchorPoint - layer.anchorPoint
        layer.anchorPoint = newAnchorPoint
        let translation = CGPoint(x: anchorTranslation.x * bounds.size.width, y: anchorTranslation.y * bounds.size.height)
        transform = CGAffineTransform(translationX: translation.x, y: translation.y).concatenating(transform)
    }
    
    func heightWidthAnchor(equalTo constarint: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        heightAnchor.constraint(equalTo: constarint, multiplier: multiplier, constant: constant).isActive = true
        widthAnchor.constraint(equalTo: constarint, multiplier: multiplier, constant: constant).isActive = true
    }
    
    func heightWidthAnchor(equalToConstant constant: CGFloat) {
        heightAnchor.constraint(equalToConstant: constant).isActive = true
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func centerXYAnchor(equalToViewCenter constrainToView: UIView) {
        centerYAnchor.constraint(equalTo: constrainToView.centerYAnchor).isActive = true
        centerXAnchor.constraint(equalTo: constrainToView.centerXAnchor).isActive = true
    }
    
    func subviewsContains(_ view: UIView) -> Bool {
        let subviews = self.subviews
        for subview in subviews {
            if subview == view {
                return true
            }
        }
        for subview in subviews {
            if subview.subviewsContains(view) {
                return true
            }
        }
        return false
    }
    
    func superviewsContains(_ view: UIView) -> Bool {
        if let parent = superview {
            if parent == view {
                return true
            }
            return superviewsContains(parent)
        }
        return false
    }
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        return renderer.image { ctx in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
    }

}


extension CALayer {
    
    func asImage(size: CGSize? = nil) -> UIImage {
        let bounds = size == nil ? bounds : .init(origin: .zero, size: size!)
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            render(in: rendererContext.cgContext)
        }
    }
    
}
