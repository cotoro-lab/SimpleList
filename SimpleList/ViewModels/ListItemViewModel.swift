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
        let items = Array(1...20);
        var itemid: Int = 0;
        
        for item in items {
            let tag_num: Int = Int(arc4random_uniform(3) + 1)
            
            listItems.append(ListItemModel(
                 listitem_itemid: itemid
                , listitem_tagno: tag_num
                , listitem_name: "\(item)hogehoge"
            ));
            
            itemid = itemid + 1;
        }
    }
    
    func getTagImageName(tagid: Int) -> String {
        var image_name: String = "gray_image"
        
        if let val = common.dicTags[tagid]{
            image_name = val;
        }
        
        return image_name;
    }
    
}
