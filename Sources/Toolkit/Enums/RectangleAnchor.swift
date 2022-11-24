//
//  RectLocation.swift
//  old-version-of-secret-project
//
//  Created by Ilias Nikolaidis Olsson on 2021-12-30.
//

import QuartzCore

public enum RectangleAnchor {
    case center
    
    case topCenter
    case bottomCenter
    case leftCenter
    case rightCenter
    
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

public extension RectangleAnchor {
    
    var opposite: RectangleAnchor {
        switch self {
        case .center:
            return .center
        case .topCenter:
            return .bottomCenter
        case .bottomCenter:
            return .topCenter
        case .leftCenter:
            return .rightCenter
        case .rightCenter:
            return .leftCenter
        case .topLeft:
            return .bottomRight
        case .topRight:
            return .bottomLeft
        case .bottomLeft:
            return .topRight
        case .bottomRight:
            return .topLeft
        }
    }
    
    var isCorner: Bool {
        switch self {
        case .topLeft:
            return true
        case .topRight:
            return true
        case .bottomLeft:
            return true
        case .bottomRight:
            return true
        default:
            return false
        }
    }
    
    static var allCases: [RectangleAnchor] {[.center, .topCenter, .bottomCenter, .leftCenter, .rightCenter, .topLeft, .topRight, .bottomLeft, .bottomRight]}
    
}

public extension CGRect {
    
    func increase(byTranslation translation: CGPoint, fromAnchor anchor: RectangleAnchor, keepAspect: Bool) -> CGRect {
        return increase(byTranslation: translation, fromAnchor: anchor, keepAspect: keepAspect, containWithinRect: nil, magnetLines: [], snapOnDistance: 0, magnetLinesCompletion: nil)
    }
    
    func increase(byTranslation translation: CGPoint, fromAnchor anchor: RectangleAnchor, keepAspect: Bool, containWithinRect parentRect: CGRect?, magnetLines: [AxisLine], snapOnDistance: CGFloat, magnetLinesCompletion: (([AxisLine]) -> ())? = nil) -> CGRect {
        var translation = translation
        let handle = location(forAnchor: anchor.opposite)
        var handleTranslated = handle + translation
        if let parentRect = parentRect {
            if handleTranslated.x > parentRect.maxX {
                handleTranslated.x = parentRect.maxX
            } else if handleTranslated.x < parentRect.minX {
                handleTranslated.x = parentRect.minX
            }
            if handleTranslated.y < parentRect.minY {
                handleTranslated.y = parentRect.minY
            } else if handleTranslated.y > parentRect.maxY {
                handleTranslated.y = parentRect.maxY
            }
        }
        translation = handleTranslated - handle
        
        if anchor != .center && !magnetLines.isEmpty {
            var magnetLines = magnetLines
            switch anchor {
            case .topCenter, .bottomCenter:
                magnetLines = magnetLines.filter {$0.axis == .vertical}
            case .leftCenter, .rightCenter:
                magnetLines = magnetLines.filter {$0.axis == .horizontal}
            default:
                break
            }
            
            var linesUsed = [AxisLine]()
            let magnetAndDistances: [(magnet: AxisLine, distance: CGFloat)] = magnetLines.map {($0, abs($0.offset - handleTranslated.float(onAxis: $0.axis)))}
            if let (nearestHorizontalMagnet, horizontalMagnetDistance) = magnetAndDistances.filter({$0.magnet.axis == .horizontal}).min(by: {a, b in a.distance < b.distance}) {
                if horizontalMagnetDistance < snapOnDistance {
                    linesUsed.append(nearestHorizontalMagnet)
                    translation.x = nearestHorizontalMagnet.offset - handle.x
                }
            }
            if let (nearestVerticalMagnet, verticalMagnetDistance) = magnetAndDistances.filter({$0.magnet.axis == .vertical}).min(by: {a, b in a.distance < b.distance}) {
                if verticalMagnetDistance < snapOnDistance {
                    linesUsed.append(nearestVerticalMagnet)
                    translation.y = nearestVerticalMagnet.offset - handle.y
                }
            }
            magnetLinesCompletion?(linesUsed)
        } else {
            magnetLinesCompletion?([])
        }
        
        let newFrame = {() -> CGRect in
            switch anchor {
            case .center:
                return .init(center: center, size: .init(width: size.width + translation.x, height: size.height + translation.y))
            case .topCenter:
                if keepAspect {
                    let aspectToWidth = size.width / size.height
                    let newHeight = size.height + translation.y
                    return .init(x: origin.x, y: origin.y, width: newHeight * aspectToWidth, height: newHeight)
                }
                return .init(x: origin.x, y: origin.y, width: size.width, height: size.height + translation.y)
            case .bottomCenter:
                if keepAspect {
                    let aspectToWidth = size.width / size.height
                    let newHeight = size.height - translation.y
                    return .init(x: origin.x, y: origin.y + translation.y, width: newHeight * aspectToWidth, height: newHeight)
                }
                return .init(x: origin.x, y: origin.y + translation.y, width: size.width, height: size.height - translation.y)
            case .leftCenter:
                if keepAspect {
                    let aspectToHeight = size.height / size.width
                    let newWidth = size.width + translation.x
                    return .init(x: origin.x, y: origin.y, width: newWidth, height: newWidth * aspectToHeight)
                }
                return .init(x: origin.x, y: origin.y, width: size.width + translation.x, height: size.height)
            case .rightCenter:
                if keepAspect {
                    let aspectToHeight = size.height / size.width
                    let newWidth = size.width - translation.x
                    return .init(x: origin.x + translation.x, y: origin.y, width: newWidth, height: newWidth * aspectToHeight)
                }
                return .init(x: origin.x + translation.x, y: origin.y, width: size.width - translation.x, height: size.height)
            default:
                if keepAspect {
                    let scale = handle.scale(forReaching: handleTranslated, byScalingFrom: location(forAnchor: anchor))
                    let linearScale = scale.x.interpolateTo(scale.y, amount: 0.5)
                    let newSize = CGSize(width: width * linearScale, height: height * linearScale)
                    translation = .init(x: newSize.width - size.width, y: newSize.height - size.height)
                }
                switch anchor {
                case .topLeft:
                    return .init(x: origin.x, y: origin.y, width: size.width + translation.x, height: size.height + translation.y)
                case .topRight:
                    if keepAspect {
                        let newWidth = size.width + translation.x
                        if newWidth < 0 {
                            return .init(x: origin.x + size.width, y: origin.y, width: abs(newWidth), height: size.height + translation.y)
                        }
                        return .init(x: origin.x + translation.x, y: origin.y, width: size.width + translation.x, height: size.height + translation.y)
                    }
                    return .init(x: origin.x + translation.x, y: origin.y, width: size.width - translation.x, height: size.height + translation.y)
                case .bottomLeft:
                    if keepAspect {
                        let newHeight = size.height + translation.y
                        if newHeight < 0 {
                            return .init(x: origin.x, y: origin.y + size.height, width: size.width + translation.x, height: abs(newHeight))
                        }
                        return .init(x: origin.x, y: origin.y + translation.y, width: size.width + translation.x, height: size.height + translation.y)
                    }
                    return .init(x: origin.x, y: origin.y + translation.y, width: size.width + translation.x, height: size.height - translation.y)
                case .bottomRight:
                    if keepAspect {
                        return .init(x: origin.x - translation.x, y: origin.y - translation.y, width: size.width + translation.x, height: size.height + translation.y)
                    }
                    return .init(x: origin.x + translation.x, y: origin.y + translation.y, width: size.width - translation.x, height: size.height - translation.y)
                default:
                    return self
                }
            }
        }()
        let minX = newFrame.minX
        let minY = newFrame.minY
        let maxX = newFrame.maxX
        let maxY = newFrame.maxY
        return .init(origin: .init(x: minX, y: minY), size: .init(width: maxX - minX, height: maxY - minY))
    }

    func anchor(forLocation point: CGPoint, excludeAnchors: [RectangleAnchor] = []) -> (anchor: RectangleAnchor, distance: CGFloat) {
        let anchorWithLocation: [(anchor: RectangleAnchor, location: CGPoint)] = RectangleAnchor.allCases.filter({!excludeAnchors.contains($0)}).map {($0, location(forAnchor: $0))}
        let anchorWithDistance: [(anchor: RectangleAnchor, distance: CGFloat)] = anchorWithLocation.map {($0.anchor, $0.location.distanceTo(point))}
        return anchorWithDistance.min(by: {a, b in a.distance < b.distance})!
    }
    
    func location(forAnchor anchor: RectangleAnchor) -> CGPoint {
        switch anchor {
        case .center:
            return self.center
        
        case .topCenter:
            return CGPoint(x: midX, y: minY)
        case .bottomCenter:
            return CGPoint(x: midX, y: maxY)
        case .leftCenter:
            return CGPoint(x: minX, y: midY)
        case .rightCenter:
            return CGPoint(x: maxX, y: midY)
            
        case .topLeft:
            return self.topLeft
        case .topRight:
            return self.topRight
        case .bottomLeft:
            return self.bottomLeft
        case .bottomRight:
            return self.bottomRight
        }
    }

}
