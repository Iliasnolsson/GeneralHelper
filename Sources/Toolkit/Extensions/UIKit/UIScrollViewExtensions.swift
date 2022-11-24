//
//  UIScrollViewExtensions.swift
//  secret-project
//
//  Created by Ilias Nikolaidis Olsson on 2022-11-23.
//

import UIKit

public extension UIScrollView {
    
    func contentInset(adjustToAllowCenteringOnFirst first: CGFloat, last: CGFloat, axis: Axis) {
        switch axis {
        case .horizontal:
            contentInset.right = ((bounds.width / 2) - (last / 2)).ifAbnormal(changeTo: 0)
            contentInset.left = ((bounds.width / 2) - (first / 2)).ifAbnormal(changeTo: 0)
        case .vertical:
            contentInset.top = ((bounds.height / 2) - (last / 2)).ifAbnormal(changeTo: 0)
            contentInset.bottom = ((bounds.height / 2) - (first / 2)).ifAbnormal(changeTo: 0)
        }
    }
    
    func closestToCenter(of views: [UIView], forOffset offset: CGFloat? = nil, axis: Axis = .horizontal) -> Int? {
        return closestToCenter(of: views.map({$0.frame}), forOffset: offset, axis: axis)
    }
    
    func closestToCenter(of frames: [CGRect], forOffset offset: CGFloat? = nil, axis: Axis = .horizontal) -> Int? {
        let ranges: [ClosedRange<CGFloat>] = frames.map { $0.range(on: axis) }
        return closestToCenter(of: ranges, forOffset: offset, axis: axis)
    }
    
    func closestToCenter(of ranges: [ClosedRange<CGFloat>], forOffset offset: CGFloat? = nil, axis: Axis = .horizontal) -> Int? {
        let offset = offset ?? contentOffset.float(onAxis: axis)
        let targetCenter = offset + bounds.width / 2
        let distances = ranges.map { range in
            return abs(range.mid - targetCenter)
        }
        if let minDistance = distances.min() {
            return distances.firstIndex(of: minDistance)
        }
        return nil
    }
    
    func offset(forCenteringOn view: UIView, axis: Axis = .horizontal) -> CGFloat {
        return offset(forCenteringOn: view.frame, axis: axis)
    }
    
    func offset(forCenteringOn frame: CGRect, axis: Axis = .horizontal) -> CGFloat {
        switch axis {
        case .horizontal:
            let targetCenter = frame.midX
            return targetCenter - bounds.width / 2
        case .vertical:
            let targetCenter = frame.midY
            return targetCenter - bounds.height / 2
        }
    }
    
}

