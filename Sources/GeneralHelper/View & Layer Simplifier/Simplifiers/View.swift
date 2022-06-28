//
//  View.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-10.
//

import UIKit

open class View: UIView {
    
    public var corners: Corners? {_corners}
    private var _corners: Corners? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    open override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        reloadCorners()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: Corners
public extension View {
    
    func setCorners(_ value: CGFloat, valueType: Corners.ValueType) {
        setCorners(.init(value, valueType: valueType))
    }
    
    func setCorners(_ newCorners: Corners?) {
        _corners = newCorners
        reloadCorners()
    }
    
    private func reloadCorners() {
        if let corners = corners {
            layer.cornerRadius = corners.radius(forViewSize: bounds.size)
        }
    }
    
}

public extension View {
    
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


public extension View {
    
    struct Corners {
        /// Default is 3, Corner Radius of background
        public var value: CGFloat = 3
        /// Default is constant, How the corner radius value should be interperted
        public var valueType: ValueType
        
        public init(_ value: CGFloat, valueType: ValueType = .constant) {
            self.value = value
            self.valueType = valueType
        }
        
        public init() {
            self.value = 3
            self.valueType = .constant
        }
        
        public enum ValueType {
            case constant
            case percentageOfHeight
            case percentageOfWidth
            case percentageOfSizeMax
            case percentageOfSizeMin
        }
        
        func radius(forViewSize size: CGSize) -> CGFloat {
            switch valueType {
            case .constant:
                return value
            case .percentageOfHeight:
                return value * size.height
            case .percentageOfWidth:
                return value * size.width
            case .percentageOfSizeMax:
                return value * max(size.width, size.height)
            case .percentageOfSizeMin:
                return value * min(size.width, size.height)
            }
        }
        
        static var rounded: Corners = .init(0.5, valueType: .percentageOfSizeMin)
        static var almostRounded: Corners = .init(0.975, valueType: .percentageOfSizeMin)
        
        static var small: Corners = .init(2, valueType: .constant)
        static var medium: Corners = .init(6, valueType: .constant)
        static var large: Corners = .init(12, valueType: .constant)
    }
    
}
