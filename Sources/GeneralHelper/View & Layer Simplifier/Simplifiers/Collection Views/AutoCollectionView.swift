//
//  OpenCollectionView.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-02-08.
//

import UIKit

class AutoCollectionView: CollectionView {
    
    private(set) var register = [String]()
    
    override func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        if cellClass == nil {
            if let identifierIndex = register.firstIndex(of: identifier) {
                register.remove(at: identifierIndex)
            }
        } else if !register.contains(identifier) {
            register.append(identifier)
        }
        super.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    func cell<T: UICollectionViewCell>(forClass: T.Type, forPath path: IndexPath) -> T {
        return cell(forIdentifier: String(describing: forClass), cellClass: forClass, forPath: path) as! T
    }
    
    private func cell(forIdentifier identifier: String, cellClass: AnyClass, forPath path: IndexPath) -> UICollectionViewCell {
        if !register.contains(identifier) {
            register.append(identifier)
            super.register(cellClass, forCellWithReuseIdentifier: identifier)
        }
        return super.dequeueReusableCell(withReuseIdentifier: identifier, for: path)
    }

}
