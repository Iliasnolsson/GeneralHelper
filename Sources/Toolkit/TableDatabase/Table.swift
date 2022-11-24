//
//  Table.swift
//  secret-project
//
//  Created by Ilias Nikolaidis Olsson on 2022-11-17.
//

import Foundation
import SQLite

open class Table<T>: TableBase {
    
    public let sqlTable: SQLite.Table
    
    public init(name: String) {
        self.sqlTable = .init(name)
    }
    
    open func create(tables: T) throws {
        fatalError("initalize(tables: Tables) - not implemented")
    }
    
    open func initalize(tables: T) throws {
    }

}


