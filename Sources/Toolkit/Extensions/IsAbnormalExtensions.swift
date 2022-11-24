//
//  IsAbnormalExtensions.swift
//  secret-project
//
//  Created by Ilias Nikolaidis Olsson on 2022-11-10.
//

import QuartzCore

public extension CGFloat {
    
    func ifAbnormal(changeTo value: CGFloat) -> CGFloat {
        return isNormal ? self : value
    }

}

public extension CGPoint {
    
    func ifAbnormal(changeTo value: CGPoint) -> CGPoint {
        if x.isNormal && y.isNormal {
            return self
        }
        return value
    }
    
}

public extension CGSize {
    
    func ifAbnormal(changeTo value: CGSize) -> CGSize {
        if width.isNormal && height.isNormal {
            return self
        }
        return value
    }
    
}

