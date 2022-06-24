//
//  ArrowLayer.swift
//  KognitivKalender
//
//  Created by Ilias Nikolaidis Olsson on 2021-12-04.
//

import QuartzCore

class ArrowLayer: CALayer {
    
    private var _curve: CubicCurve?
    var curve: CubicCurve? {
        get {_curve}
        set {setCurve(newValue)}
    }
    
    private var _arrowHeight: CGFloat = 23
    var arrowHeight: CGFloat {
        get {_arrowHeight}
        set {_arrowHeight = newValue; setCurve(curve)}
    }
    
    var tailWidth: CGFloat {
        get {tailLayer.lineWidth}
        set {tailLayer.lineWidth = newValue}
    }
    
    var color: CGColor? {
        get {tailLayer.strokeColor}
        set {
            tailLayer.strokeColor = newValue
            arrowLayer.fillColor = newValue
        }
    }
    
    let tailLayer = CAShapeLayer()
    let arrowLayer = CAShapeLayer()
    
    override init() {
        super.init()
        tailLayer.fillColor = CGColor(gray: 0, alpha: 0)
        color = .init(gray: 0, alpha: 1)
        tailWidth = 5.8
        tailLayer.lineCap = .round
        
        addSublayer(tailLayer)
        addSublayer(arrowLayer)
    }
    
    func setCurve(_ newCurve: CubicCurve?, animated: Bool = false, duration: Double = 0.3, option: CAMediaTimingFunction = .easeOutExpo) {
        let duration = animated ? duration : 0
        _curve = newCurve
        if let newCurve = newCurve {
            let newCurveLength = newCurve.length()
            let tailEndPointPercentage = 1 - (10 / newCurveLength)
            let tailEndPoint = newCurve.point(atPercentage: tailEndPointPercentage)
            let tailEndTangentPoint = newCurve.endTangent + (tailEndPoint - newCurve.end)
            
            let newCurvePath = CGMutablePath()
            newCurvePath.move(to: newCurve.start)
            newCurvePath.addCurve(to: tailEndPoint, control1: newCurve.startTangent, control2: tailEndTangentPoint)
            CALayer.animate(layer: tailLayer, valueKey: \.path, to: newCurvePath, duration: duration, option: option, completion: nil)
            
            let newArrowPath = CGMutablePath()
            newArrowPath.addArrow(toEndOfCubicPath: newCurve, withHeight: arrowHeight)
            CALayer.animate(layer: arrowLayer, valueKey: \.path, to: newArrowPath, duration: duration, option: option, completion: nil)
        } else {
            tailLayer.path = nil
            arrowLayer.path = nil
        }
    }
    
    required init?(coder: NSCoder) {
        super.init()
    }
    
}
