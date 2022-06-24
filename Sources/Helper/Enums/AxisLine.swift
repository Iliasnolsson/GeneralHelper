//
//  AxisFloat.swift
//  Lotte
//
//  Created by Ilias Nikolaidis Olsson on 2021-12-30.
//

import QuartzCore

struct AxisLine: Equatable {
    let offset: CGFloat
    let axis: Axis
}

extension CGRect {
    
    func lines() -> [AxisLine] {
        return lines(onAxis: .horizontal) + lines(onAxis: .vertical)
    }
    
    func lines(onAxis axis: Axis) -> [AxisLine] {
        if axis == .horizontal {
            return [.init(offset: minY, axis: .vertical), .init(offset: midY, axis: .vertical), .init(offset: maxY, axis: .vertical)]
        } else {
            return [.init(offset: minX, axis: .horizontal), .init(offset: midX, axis: .horizontal), .init(offset: maxX, axis: .horizontal)]
        }
    }
    
}
