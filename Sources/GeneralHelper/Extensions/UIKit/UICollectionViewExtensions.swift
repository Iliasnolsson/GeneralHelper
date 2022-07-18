//
//  File.swift
//  
//
//  Created by Ilias Nikolaidis Olsson on 2022-07-18.
//

import UIKit

public extension UICollectionView {
    
    func register(cell cellClass: AnyClass) {
        self.register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }
    
    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T
    }
    
}
