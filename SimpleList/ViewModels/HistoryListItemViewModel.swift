//
//  HistoryListItemViewModel.swift
//  SimpleList
//
//  Created by shuta uto on 2023/09/09.
//

import SwiftUI
import Combine

class HistoryListItemViewModel: ObservableObject {
    @Published var listItems: [HistoryListItemModel] = [];
    
    let common = CommonClass();
    
    init() {
        let (success, errorMessage, selectedItems) = DBService.shared.selectItem(archiveFlg: 1)
        if(success){
            for item in selectedItems {
                listItems.append(HistoryListItemModel(
                    hli_itemId: item.item_id
                    , hli_tagNo: item.tag_no
                    , hli_name: item.item_name
                    , hli_archiveDate: item.archive_date
                ));
            }
            
        } else {
            print(errorMessage ?? "Error")
        }
    }
}
