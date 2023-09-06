//
//  MainViewModel.swift
//  SimpleList
//
//  Created by shuta uto on 2023/09/06.
//

import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    @Published var mainModels: [MainModel] = []
    
    
    func addMainModel(message: String, tag_num: Int){
        
        let newItem = MainModel(
            item_name: "\(mainModels.count + 1): " + message
            , tag_no: tag_num
        )
        mainModels.append(newItem)
    }
    
}
