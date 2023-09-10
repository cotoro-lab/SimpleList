//
//  ListItemViewModel.swift
//  SimpleList
//
//  Created by shuta uto on 2023/09/06.
//

import SwiftUI
import Combine


class ListItemViewModel: ObservableObject {
    @Published var listItems: [ListItemModel] = [];
    
    let common = CommonClass();
    
    init() {
        // 画面に表示するリストアイテムを全県取得しておく
        let (success, errorMessage, selectedItems) = DBService.shared.selectItem(archiveFlg: 0)
        if(success){
            for item in selectedItems {
                listItems.append(ListItemModel(
                    listitem_itemid: item.item_id
                    , listitem_tagno: item.tag_no
                    , listitem_name: item.item_name
                ));
            }
            
        } else {
            print(errorMessage ?? "Error")
        }
    }
    
    // 表示するリストアイテムのデータを追加するメソッド
    func addItem(itemId: Int ,tagNo: Int, itemName: String) {
        listItems.append(ListItemModel(
            listitem_itemid: itemId
            , listitem_tagno: tagNo
            , listitem_name: itemName
        ));
        
    }
    
    // 表示するリストアイテムのデータを削除するメソッド
    func removeItem(item: ListItemModel) {
        listItems.removeAll{
            $0.listitem_itemid == item.listitem_itemid
            && $0.listitem_tagno == item.listitem_tagno
            && $0.listitem_name == item.listitem_name
        }
    }
}
