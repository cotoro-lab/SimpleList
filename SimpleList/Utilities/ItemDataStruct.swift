//
//  ItemDataStruct.swift
//  SimpleList
//
//  Created by shuta uto on 2023/08/31.
//

import Foundation

struct ItemDataStruct {
    var item_id: Int
    var item_name: String
    var tag_no: Int
    var create_date: Date
    var archive_date: Date
    var delete_flg: Bool
    
    init(item_id: Int, item_name: String, tag_no: Int, create_date: Date, archive_date: Date, delete_flg: Bool) {
        self.item_id = item_id
        self.item_name = item_name
        self.tag_no = tag_no
        self.create_date = create_date
        self.archive_date = archive_date
        self.delete_flg = delete_flg
    }
}
