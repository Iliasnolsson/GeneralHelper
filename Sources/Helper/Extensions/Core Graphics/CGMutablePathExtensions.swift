//
//  CGMutablePath.swift
//  CGMutablePath
//
//  Created by Ilias Nikolaidis Olsson on 2021-08-22.
//

import QuartzCore

extension CGMutablePath {
    
    // Degrees start from middle top of circle, not at 90 degrees as it usually would
    func addArcLogical(center: CGPoint, radius: CGFloat, startDegrees: CGFloat, endDegrees: CGFloat, clockwise: Bool) {
        addArc(center: center, radius: radius, startAngle: (startDegrees - 90).toRadians(), endAngle: (endDegrees - 90).toRadians(), clockwise: clockwise)
    }
    
    func addArrow(pointingAt end: CGPoint, from start: CGPoint, arrowAngle: CGFloat, height: CGFloat? = nil) {
        let pointerLineLength = height ?? start.distanceTo(end)
        move(to: end)
        let startEndAngle = atan((end.y - start.y) / (end.x - start.x)) + ((end.x - start.x) < 0 ? CGFloat(Double.pi) : 0)
        let arrowLine1 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle + arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle + arrowAngle))
        let arrowLine2 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle - arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle - arrowAngle))
        addLine(to: arrowLine1)
        move(to: end)
        addLine(to: arrowLine2)
        addLine(to: arrowLine1)
    }
    
    func addArrow(toEndOfCubicPath cubicPath: CubicCurve, withHeight height: CGFloat) {
        let cubicPathLength = cubicPath.length()
        let fromPointPercentage = 1 - (10 / cubicPathLength)
        addArrow(pointingAt: cubicPath.end, from: cubicPath.point(atPercentage: max(0.05, fromPointPercentage)), arrowAngle: CGMutablePath.arrowAngle, height: height)
    }
    
    func addArrowWithTail(pointingAt toPoint: CGPoint, withTangent toTangnet: CGPoint, fromPoint: CGPoint, withTangent fromTangent: CGPoint, arrowHeight: CGFloat) {
        let cubicPath = CubicCurve(start: toPoint, startTangent: toTangnet, end: fromPoint, endTangent: fromTangent)
        addPath(cubicPath.cgPath())
        addArrow(pointingAt: toPoint, from: cubicPath.point(atPercentage: 0.05), arrowAngle: CGMutablePath.arrowAngle, height: arrowHeight)
    }
    
    func addArrowWithTail(pointingToEndOf cubicPath: CubicCurve, arrowHeight: CGFloat, tailWidth: CGFloat, lineCap: CGLineCap = .round, lineJoin: CGLineJoin = .round) {
        let cubicPathLength = cubicPath.length()
        let fromPointPercentage = 1 - (10 / cubicPathLength)
        addArrow(pointingAt: cubicPath.end, from: cubicPath.point(atPercentage: max(0.05, fromPointPercentage)), arrowAngle: CGMutablePath.arrowAngle, height: arrowHeight)
        var tailCubicPath = cubicPath
        let tailEndPercentage = 1 - (9 / cubicPathLength)
        tailCubicPath.end = cubicPath.point(atPercentage: tailEndPercentage)
        tailCubicPath.endTangent = tailCubicPath.endTangent + (tailCubicPath.end - cubicPath.end)
        let tailPath = tailCubicPath.cgPath().copy(strokingWithWidth: tailWidth, lineCap: lineCap, lineJoin: lineJoin, miterLimit: 1)
        addPath(tailPath)
    }
    
    static var arrowAngle: CGFloat { 37.cgFloat.toRadians()}
    
    func scaleAroundCenter(by factor: CGFloat) -> CGMutablePath {
        let beforeBounds = boundingBoxOfPath
        let beforeCenter = CGPoint(x: beforeBounds.midX, y: beforeBounds.midY)
        
        // SCALE path by factor
        var scaleTransform = CGAffineTransform(scaleX: factor, y: factor)
        guard let pathScaled = copy(using: &scaleTransform) else {return self}

        let afterBounds = boundingBoxOfPath
        let afterCenter = CGPoint(x: afterBounds.midX, y: afterBounds.midY)
        let diff = CGPoint(x: beforeCenter.x - afterCenter.x, y: beforeCenter.y - afterCenter.y)
        
        var translateTransform = CGAffineTransform(translationX: diff.x, y: diff.y)
        guard let pathTranslated = pathScaled.copy(using: &translateTransform)?.mutableCopy() else {return self}
        return pathTranslated
    }
    
    func scaleAspectFitAroundCenter(to toSize: CGSize) -> CGMutablePath {
        let fromSize = boundingBoxOfPath.size
        return scaleAroundCenter(by: fromSize.scaleToFit(in: toSize))
    }
    
    func translated(by translation: CGPoint) -> CGMutablePath {
        var translateTransform = CGAffineTransform(translationX: translation.x, y: translation.y)
        return copy(using: &translateTransform)?.mutableCopy() ?? self
    }
    
}
