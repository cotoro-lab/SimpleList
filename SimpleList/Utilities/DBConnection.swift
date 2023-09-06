//
//  DBConnection.swift
//  SimpleList
//
//  Created by shuta uto on 2023/08/30.
//

import Foundation
import SQLite3

final class DBService {
    static let shared = DBService()
    
    private let dbFile = "SListDB.sqlite"
    private var db: OpaquePointer?
    
    private init() {
        db = openDataBase()
        if !createTable() {
            print("Failed to create table")
        }
    }
    
    private func openDataBase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
                                                   create: false).appendingPathComponent(dbFile)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Failed to open database")
            return nil
        }
        else {
            print("Opened connection to database")
            return db
        }
    }
    
    private func createTable() -> Bool {
        let createSql = """
        CREATE TABLE items (
            item_id INTEGER PRIMARY KEY AUTOINCREMENT,
            item_name TEXT NOT NULL,
            tag_no INTEGER,
            create_date TEXT,
            archive_date TEXT,
            delete_flg INTEGER DEFAULT 0
        );
        """
        
        var createStmt:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, (createSql as NSString).utf8String, -1, &createStmt, nil) != SQLITE_OK {
            print("db error: \(getDBErrorMessage(db))")
            return false
        }
        
        if sqlite3_step(createStmt) != SQLITE_DONE {
            print("db error: \(getDBErrorMessage(db))")
            sqlite3_finalize(createStmt)
            return false
        }
        
        sqlite3_finalize(createStmt)
        return true
    }
    
    private func getDBErrorMessage(_ db: OpaquePointer?) -> String {
        if let err = sqlite3_errmsg(db) {
            return String(cString: err)
        } else {
            return ""
        }
    }
}
