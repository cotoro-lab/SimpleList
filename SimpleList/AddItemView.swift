//
//  AddItemView.swift
//  ShoppingList
//
//  Created by shuta uto on 2023/08/29.
//

import SwiftUI
import UIKit

struct AddItemView: View {
    @Binding var showAddModal: Bool
    
    @State private var item_name = ""
    @State private var backgroundColor = UIColor(CustomColors.customMyWhite)
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedTag: String = "gray_image"
    let imageTags = ["gray_image", "white_image", "line_image"]
    let common = CommonClass()
    
    @State private var tagsNo: Int = 0
    
    @State private var showingAlert = false
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                // 背景
                Rectangle()
                    .fill(Color(backgroundColor))
                    .cornerRadius(15)
                    .shadow(color: .black.opacity(1), radius: 8, x: 5,y: 5)
                
                VStack(spacing: 0){
                    // 入力内容
                    HStack(spacing: 0){
                        Image(selectedTag)
                            .resizable()
                            .frame(width: geometry.size.width * 0.2)
                            .onTapGesture{
                                if let index = imageTags.firstIndex(of: selectedTag) {
                                    let nextIndex = (index + 1) % imageTags.count
                                    selectedTag = imageTags[nextIndex]
                                }
                            }
                        Rectangle()
                            .fill(Color(UIColor(CustomColors.customGray)))
                            .frame(width: 1)

                        TextField("Add Item",text: $item_name)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                            .foregroundColor(CustomColors.customGray)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.6, alignment: .leading)
                        Spacer()
                        
                    }
                    .frame(height: geometry.size.height * 0.6)
                        
                    Rectangle()
                        .fill(Color(UIColor(CustomColors.customGray)))
                        .frame(height: 1)
                    
                    // ボタン
                    HStack{
                        ZStack{
                            Rectangle()
                                .fill(Color(backgroundColor))
                                .onTapGesture{
                                    if let val = common.dicTags.first(where: { $0.value == selectedTag})?.key {
                                        tagsNo = val
                                    }
//                                    mainViewModel.addMainModel(message:item_name, tag_num:tagsNo)
                                    // モーダルを閉じる
                                    self.showAddModal = false
                                }
                            Text("Add")
                                .foregroundColor(CustomColors.customGray)
                        }
                        
                        Rectangle()
                            .fill(Color(UIColor(CustomColors.customGray)))
                            .frame(width: 1)
                        
                        ZStack{
                            Rectangle()
                                .fill(Color(backgroundColor))
                                .onTapGesture{
                                    // モーダルを閉じる
                                    self.showAddModal = false
                                }
                            Text("Cancel")
                                .foregroundColor(CustomColors.customGray)
                        }
                    }
                }
                .cornerRadius(15)
            }
        }
    }
}

//struct AddItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddItemView()
//    }
//}
