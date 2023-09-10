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
    
    
    /// ******************************
    ///  テーブル作成
    /// ******************************
    private func createTable() -> Bool {
        let createSql = """
        CREATE TABLE items (
            item_id INTEGER PRIMARY KEY AUTOINCREMENT,
            tag_no INTEGER NOT NULL,
            item_name TEXT ,
            create_date TEXT NOT NULL,
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
    
    /// ******************************
    /// INSERTの実行
    /// ******************************
    func isertItem(item: ItemDataStruct) -> Bool {
        
        // INSERT文
        let insertSql = """
                        INSERT INTO items
                            (tag_no, item_name, create_date, archive_date, delete_flg)
                            VALUES
                            ( ?, ?, ?, ?, ?);
                        """;
        
        var insertStmt: OpaquePointer? = nil
        
        // SQL文のコンパイル
        if sqlite3_prepare_v2(db, (insertSql as NSString).utf8String, -1, &insertStmt, nil) != SQLITE_OK {
            print("db error: \(getDBErrorMessage(db))")
            return false
        }
        
        // 関連付け
        sqlite3_bind_int(insertStmt, 1, Int32(item.tag_no))
        sqlite3_bind_text(insertStmt, 2, (item.item_name as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStmt, 3, (item.create_date as NSString).utf8String, -1 ,nil)
        sqlite3_bind_text(insertStmt, 4, (item.archive_date as NSString).utf8String, -1 ,nil)
        sqlite3_bind_int(insertStmt, 5, Int32(item.delete_flg))
        
        // INSERTの実行
        if sqlite3_step(insertStmt) != SQLITE_DONE {
            print("db error: \(getDBErrorMessage(db))")
            sqlite3_finalize(insertStmt)
            return false
        }
        
        // INSERT終了処理
        sqlite3_finalize(insertStmt)
        
        return true;
    }
    
    /// ******************************
    /// SELECTの実行
    /// ******************************
    func selectItem(archiveFlg: Int) -> (success: Bool, errorMessage: String?, [ItemDataStruct]){
        var selectedItems: [ItemDataStruct] = []
        
        var sql = "SELECT "
        sql += "item_id, tag_no, item_name, create_date, archive_date, delete_flg "
        sql += "FROM items "
        sql += "WHERE delete_flg = 0"
        //　archiveFlg：0でメイン表示の対象を取得
        if archiveFlg == 0 {
            sql += " and archive_date = ''"
        }else{
            sql += " and archive_date <> ''"
            sql += "ORDER BY archive_date DESC"
        }
        sql += ";"
        
        var stmt: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, (sql as NSString).utf8String, -1, &stmt, nil) == SQLITE_OK {
            // １件ずつセット
            while sqlite3_step(stmt) == SQLITE_ROW {
                let row_item_id = sqlite3_column_int(stmt, 0)
                let row_tag_no = sqlite3_column_int(stmt, 1)
                let row_item_name = String(describing: String(cString: sqlite3_column_text(stmt, 2)))
                let row_create_date = String(describing: String(cString: sqlite3_column_text(stmt, 3)))
                let row_archive_date = String(describing: String(cString: sqlite3_column_text(stmt, 4)))
                let row_delete_flg = sqlite3_column_int(stmt, 5)
                
                let item = ItemDataStruct(
                    item_id: Int(row_item_id)
                    , tag_no: Int(row_tag_no)
                    , item_name: row_item_name
                    , create_date: row_create_date
                    , archive_date: row_archive_date
                    , delete_flg: Int(row_delete_flg)
                )
                
                selectedItems.append(item)
            }
        }
        else
        {
            return (false, "Unexpected error: \(getDBErrorMessage(db)).", selectedItems)
        }
        
        // SELECT終了処理
        sqlite3_finalize(stmt)
        
        return(true, nil, selectedItems)
    }
    
    /// ******************************
    /// アーカイブ
    /// ******************************
    func ItemArchive(listItemM: ListItemModel){
        let sql = """
                    UPDATE items
                    SET archive_date = ?
                    WHERE item_id = ?
                    and archive_date = ''
                    and delete_flg = 0;
                    """
        let archiveDate: String = CommonClass().getDateTimeNow()
        
        var updateStmt: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, (sql as NSString).utf8String, -1, &updateStmt, nil) != SQLITE_OK {
            print("db error: \(getDBErrorMessage(db))")
        }
        
        sqlite3_bind_text(updateStmt, 1, (archiveDate as NSString).utf8String, -1, nil)
        sqlite3_bind_int(updateStmt, 2, Int32(listItemM.listitem_itemid))
        
        if sqlite3_step(updateStmt) != SQLITE_DONE {
            print("db error: \(getDBErrorMessage(db))")
            sqlite3_finalize(updateStmt)
        }
        sqlite3_finalize(updateStmt)
    }
    
    /// ******************************
    /// 論理削除
    /// ******************************
    func ItemDelete(listItemM: ListItemModel){
        let sql = """
                    UPDATE items
                    SET delete_flg = 1
                    WHERE item_id = ?
                    and archive_date = ''
                    and delete_flg = 0;
                    """
        
        var updateStmt: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, (sql as NSString).utf8String, -1, &updateStmt, nil) != SQLITE_OK {
            print("db error: \(getDBErrorMessage(db))")
        }
        
        sqlite3_bind_int(updateStmt, 1, Int32(listItemM.listitem_itemid))
        
        if sqlite3_step(updateStmt) != SQLITE_DONE {
            print("db error: \(getDBErrorMessage(db))")
            sqlite3_finalize(updateStmt)
        }
        sqlite3_finalize(updateStmt)
    }
    
    /// ******************************
    /// 物理削除
    /// 1ヶ月前のデータを物理削除する
    /// ******************************
    func FixTermRemoveRecord(){
        
        var sql = "DELETE FROM items "
        sql += "WHERE ( archive_date <> '' AND archive_date <= " + CommonClass().getDTLastMonth() + ") "
        sql += "OR ( delete_flg = 1 AND create_date <= " + CommonClass().getDTLastMonth() + " );"
        
        var updateStmt: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, (sql as NSString).utf8String, -1, &updateStmt, nil) != SQLITE_OK {
            print("db error: \(getDBErrorMessage(db))")
        }
        
        if sqlite3_step(updateStmt) != SQLITE_DONE {
            print("db error: \(getDBErrorMessage(db))")
            sqlite3_finalize(updateStmt)
        }
        sqlite3_finalize(updateStmt)
    }
    
    /// ******************************
    /// item_idの最大値を取得する。
    /// ******************************
    func getMaxId() -> Int? {
        let sql = "SELECT Max(item_id) FROM items ;"
        
        var stmt: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, (sql as NSString).utf8String, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_ROW {
                let maxId = sqlite3_column_int(stmt, 0)
                sqlite3_finalize(stmt)
                return Int(maxId)
            }
        }
        
        sqlite3_finalize(stmt)
        return nil
    }
}
