//
//  AddItemView.swift
//  ShoppingList
//
//  Created by shuta uto on 2023/08/29.
//

import SwiftUI
struct AddItemView: View {
    @Binding var showAddModal: Bool
    
    @State private var backgroundColor = UIColor(CustomColors.customMyWhite)
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedTag: String = "black_image"
    let imageTags = ["black_image", "white_image", "diagonal_line_image"]
    
    @State private var showingAlert = false
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                // 背景
                Rectangle()
                    .fill(Color(backgroundColor))
                    .cornerRadius(15)
                
                VStack{
                    // 入力内容
                    HStack{
                        Image(selectedTag)
                            .resizable()
                            .frame(width: geometry.size.width * 0.3)
                            .onTapGesture{
                                if let index = imageTags.firstIndex(of: selectedTag) {
                                    let nextIndex = (index + 1) % imageTags.count
                                    selectedTag = imageTags[nextIndex]
                                }
                            }
                        Text("hogehoge")
                            .foregroundColor(CustomColors.customGray)
                            .frame(width: geometry.size.width * 0.7, alignment: .leading)
                        
                    }
                        Rectangle()
                            .fill(Color(UIColor(CustomColors.customGray)))
                            .frame(height: 3)
                    // ボタン
                    HStack{
                        ZStack{
                            Rectangle()
                                .fill(Color(backgroundColor))
                                .onTapGesture{
                                    self.showingAlert = true
                                    // モーダルを閉じる
                                    self.showAddModal = false
                                }
                                .alert(isPresented: $showingAlert){
                                    Alert(title: Text("Add"))
                                }
                            Text("Add")
                                .foregroundColor(CustomColors.customGray)
                        }
                        Rectangle()
                            .fill(Color(UIColor(CustomColors.customGray)))
                            .frame(width: 3)
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
