//
//  Database.swift
//  secret-project
//
//  Created by Ilias Nikolaidis Olsson on 2022-11-18.
//

import Foundation
import SQLite

open class KitTablesDatabase<T> {
    
    public init(tables: [KitTable<T>], wrapped: T) {
        let didExist = KitTableBase.dbExists() ?? true
        for table in tables {
            do {
                try table.create(tables: wrapped)
            } catch {
                print(error)
            }
        }
        if (!didExist) {
            populate()
        }
    }
    
    open func populate() {
    }
    
}
