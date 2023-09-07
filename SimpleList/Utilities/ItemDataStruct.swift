//
//  ItemDataStruct.swift
//  SimpleList
//
//  Created by shuta uto on 2023/08/31.
//

import Foundation

struct ItemDataStruct {
    var item_id: Int
    var tag_no: Int
    var item_name: String
    var create_date: String
    var archive_date: String
    var delete_flg: Int
    
    init(item_id: Int, tag_no: Int, item_name: String, create_date: String, archive_date: String, delete_flg: Int) {
        self.item_id = item_id
        self.tag_no = tag_no
        self.item_name = item_name
        self.create_date = create_date
        self.archive_date = archive_date
        self.delete_flg = delete_flg
    }
}
