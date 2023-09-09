//
//  HistoryListItemModel.swift
//  SimpleList
//
//  Created by shuta uto on 2023/09/09.
//

import SwiftUI

struct HistoryListItemModel: Identifiable{
    var id = UUID()
    var hli_itemId: Int
    var hli_tagNo: Int
    var hli_name: String
    var hli_archiveDate: String
}


