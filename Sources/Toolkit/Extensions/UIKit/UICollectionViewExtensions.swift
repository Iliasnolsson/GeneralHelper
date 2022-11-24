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
    
    func insertRows(_ rows: [Int], section: Int = 0) {
        insertItems(at: rows.map({.init(row: $0, section: section)}))
    }
    
    func insertRow(_ row: Int, section: Int = 0) {
        insertRows([row], section: 0)
    }

    
    func deleteRow(_ row: Int, section: Int = 0) {
        deleteRows([row], section: section)
    }
    
    func deleteRows(_ rows: [Int], section: Int = 0) {
        deleteItems(at: rows.map({.init(row: $0, section: section)}))
    }

}
