//
//  CGRectExtensions.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-17.
//

import CoreGraphics

extension Array where Element == CGRect {
    
    func boundingRect() -> CGRect? {
        var boundingRect = CGRect()
        let leftPoint = self.min {a, b in a.origin.x < b.origin.x}?.origin.x
        var rightPoint: CGFloat? {
            let rectangle = self.max {a, b in (a.origin.x + a.width) < (b.origin.x + b.width)}
            if rectangle != nil {
                return rectangle!.origin.x + rectangle!.width
            }
            return nil
        }
        let topPoint = self.min {a, b in a.origin.y < b.origin.y}?.origin.y
        var bottomPoint: CGFloat? {
            let rectangle = self.max {a, b in (a.origin.y + a.height) < (b.origin.y + b.height)}
            if rectangle != nil {
                return rectangle!.origin.y + rectangle!.height
            }
            return nil
        }
        if leftPoint != nil && rightPoint != nil && topPoint != nil && bottomPoint != nil {
            let center = CGPoint(x: leftPoint! + ((rightPoint! - leftPoint!) / 2), y: topPoint! + ((bottomPoint! - topPoint!) / 2))
            let size = CGSize(width: rightPoint! - leftPoint!, height: bottomPoint! - topPoint!)
            boundingRect.size = size
            boundingRect.origin = CGPoint(x: center.x - size.width / 2, y: center.y - size.height / 2)
            return boundingRect
        }
        return nil
    }
    
}


extension CGRect {
    
    /// Otherwise not avaliable points on a rectangle
    func points(withTransform transform: CGAffineTransform?) -> [Part : CGPoint] {
        var rectPoints = [Part : CGPoint]()
        rectPoints[.topLeft] = self.topLeft
        rectPoints[.topRight] = self.topRight
        rectPoints[.bottomLeft] = self.bottomLeft
        rectPoints[.bottomRight] = self.bottomRight
        
        rectPoints[.middleTop] = CGPoint(x: self.midX, y: self.origin.y)
        rectPoints[.middleBottom] = CGPoint(x: self.midX, y: self.origin.y + self.height)
        
        rectPoints[.middleLeft] = CGPoint(x: self.origin.x, y: self.midY)
        rectPoints[.middleRight] = CGPoint(x: self.origin.x + self.width, y: self.midY)
        
        rectPoints[.middle] = self.center
        
        if transform != nil {
            for index in rectPoints.indices {
                rectPoints[rectPoints[index].key] = rectPoints[index].value.applying(transform!)
            }
        }
        return rectPoints
    }
    
    func percentage(ofPoint point: CGPoint, relativeToPoint anchorPoint: CGPoint) -> CGPoint {
        var pointPercentage = CGPoint()
        pointPercentage.x = (point.x - anchorPoint.x) / self.width
        pointPercentage.y = (point.y - anchorPoint.y) / self.height
        return pointPercentage
    }
    
    func point(for part: Part) -> CGPoint {
        switch part {
        case .topLeft:
            return self.topLeft
        case .topRight:
            return self.topRight
        case .bottomLeft:
            return self.bottomLeft
        case .bottomRight:
            return self.bottomRight
        case .middle:
            return CGPoint(x: self.midX, y: self.midY)
        case .middleTop:
            return CGPoint(x: self.midX, y: self.origin.y)
        case .middleBottom:
            return CGPoint(x: self.midX, y: self.origin.y + self.height)
        case .middleLeft:
            return CGPoint(x: self.origin.x, y: self.midY)
        case .middleRight:
            return CGPoint(x: self.origin.x + self.width, y: self.midY)
        default:
            return .zero
        }
    }
    
}

enum Part: String {
    case topLeft
    case middleTop
    case middleBottom
    case topRight
    case bottomLeft
    case middleLeft
    case bottomRight
    case middleRight
    case rotationPoll
    case middle
    
    func opposite() -> Part {
        let linkingDict: [Part : Int] = [
            .topLeft : 0, .bottomRight : 0,
            .topRight : 1, .bottomLeft : 1,
            .middleBottom : 2, .middleTop : 2,
            .middleLeft : 3, .middleRight : 3
        ]
        if let partIndex = linkingDict.first(where: {$0.key == self})?.value {
            let opposite = linkingDict.first(where: {$0.value == partIndex && $0.key != self})?.key
            return opposite!
        } else {
            return .middle
        }
    }
    
}


