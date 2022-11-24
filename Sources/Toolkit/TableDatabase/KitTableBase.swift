//
//  TableBase.swift
//  secret-project
//
//  Created by Ilias Nikolaidis Olsson on 2022-11-18.
//

import Foundation
import SQLite

open class KitTableBase {
    
    public var db: SQLite.Connection? {KitTableBase.db}
    
}

// MARK: Statics
public extension KitTableBase {
    
    static var dbName: String? {
        return Bundle.infoPlistValue(forKey: "dbName") as? String
    }
    
    static func dbExists() -> Bool? {
        guard let dbName = dbName else {return nil}
        guard let dbUrl = dbUrl(forName: dbName) else {return nil}
        return FileManager.default.fileExists(atPath: dbUrl.path)
    }
    
    
    static var db: SQLite.Connection? = {()
        guard let dbName = dbName else {return nil}
        guard let dbDirectoryUrl = dbDirectoryUrl(forName: dbName) else {return nil}
        
        do {
            try FileManager.default.createDirectory(atPath: dbDirectoryUrl.path,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
            let sqliteName = KitTableBase.dbFileName(forName: dbName)
            let connectionPath = dbDirectoryUrl.appendingPathComponent(sqliteName).path
            let connection = try SQLite.Connection(connectionPath)
            return connection
        } catch {
            return nil
        }
    }()

    
}

// MARK: Internal - Statics
extension KitTableBase {
    
    private static func dbDirectoryUrl(forName name: String) -> URL? {
        if name.isEmpty {return nil}
        guard let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return docDir.appendingPathComponent(name + "DB")
    }
    
    private static func dbUrl(forName name: String) -> URL? {
        guard let dbDirectoryUrl = dbDirectoryUrl(forName: name) else {return nil}
        return dbDirectoryUrl.appendingPathComponent(dbFileName(forName: name))
    }
    
    private static func dbFileName(forName name: String) -> String {
        return name.lowercased() + ".sqlite3"
    }
    
}
