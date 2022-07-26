//
//  File.swift
//  
//
//  Created by Ilias Nikolaidis Olsson on 2022-07-18.
//

import UIKit

public extension UITableView {
    
    func register(cell cellClass: AnyClass) {
        self.register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    func register(header headerClass: AnyClass) {
        self.register(headerClass, forHeaderFooterViewReuseIdentifier: String(describing: headerClass))
    }
    
    func register(footer headerClass: AnyClass) {
        self.register(headerClass, forHeaderFooterViewReuseIdentifier: String(describing: headerClass))
    }
    
    func dequeueReusableHeaderFooterView<T>() -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T
    }
    
    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T
    }
    
}
