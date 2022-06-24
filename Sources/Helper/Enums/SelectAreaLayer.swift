//
//  SelectAreaTouchTargetLayer.swift
//  Lotte Object Engine
//
//  Created by Ilias Nikolaidis Olsson on 2022-01-15.
//

import QuartzCore

class SelectAreaLayer: CALayer {
    
    private(set) var area: CGRect = .zero
    
    private var areaLayer = CALayer()
    private var initalLocation = CGPoint()
    
    override init() {
        super.init()
        setup()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSublayer(areaLayer)
    }
    

    func panningWillBegin(at point: CGPoint) {
        initalLocation = point
        CALayer.stopAnimationsIn {
            areaLayer.frame = .zero
            areaLayer.opacity = 0
            areaLayer.cornerRadius = 7
            areaLayer.backgroundColor = .init(gray: 0.5, alpha: 0.1)
        }
        CALayer.animate(layer: areaLayer, valueKey: \.opacity, to: 1, duration: 0.2, option: .easeOut, completion: nil)
    }
    
    func panningChanged(to point: CGPoint) {
        let minPoint = CGPoint(x: min(point.x, initalLocation.x), y: min(point.y, initalLocation.y))
        let maxPoint = CGPoint(x: max(point.x, initalLocation.x), y: max(point.y, initalLocation.y))
        area = CGRect(origin: minPoint, size: .init(width: maxPoint.x - minPoint.x, height: maxPoint.y - minPoint.y))
        CALayer.stopAnimationsIn {
            areaLayer.frame = area
        }
    }
    
    func panningEnded() {
        CALayer.animate(layer: areaLayer, valueKey: \.opacity, to: 0, duration: 0.3, option: .easeOut, completion: nil)
    }
    
}
