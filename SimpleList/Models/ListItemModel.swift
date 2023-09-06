//
//  ListItemModel.swift
//  SimpleList
//
//  Created by shuta uto on 2023/09/06.
//
import SwiftUI

struct ListItemModel: Identifiable{
    var id = UUID()
    var listitem_itemid: Int
    var listitem_tagno: Int
    var listitem_name: String
}
