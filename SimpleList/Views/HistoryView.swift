//
//  HistoryView.swift
//  SimpleList
//
//  Created by shuta uto on 2023/09/03.
//

import SwiftUI

//HistoryView
struct HistoryView: View {
    @ObservedObject var HlistItemViewModel : HistoryListItemViewModel
    
    @State private var backgroundColor = UIColor(CustomColors.customMyWhite)
    
    @Environment(\.dismiss) var dismiss
    private let common = CommonClass()
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationStack {
                ZStack{
                    Color(backgroundColor)
                        .ignoresSafeArea()
                    VStack{
                        HStack{
                            // 戻るボタン
                            Button(
                                action: {
                                    dismiss()
                                }, label: {
                                    Image(systemName: "arrow.backward.circle")
                                        .font(Font.system(size: 25))
                                }
                            )
                            .tint(CustomColors.customGray)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: -45))
                            Spacer()
                            
                            // 履歴画面タイトル
                            Text("History")
                                .font(.title)
                                .foregroundColor(CustomColors.customGray)
                                .frame(maxWidth: .infinity )
                            Spacer()
                        }
                        
                        ZStack{
                            // 履歴アイテムリスト
                            List {
                                ForEach(HlistItemViewModel.listItems) { item in
                                    HistoryItemView(HlistItem: item)
                                        .frame(height: 60)
                                        .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                                        .listRowBackground(CustomColors.customMyWhite)
                                }
                            }
                            .scrollContentBackground(.hidden)
                            .background(CustomColors.customMyWhite)
                            
                            if HlistItemViewModel.listItems.count == 0 {
                                CustomColors.customMyWhite.edgesIgnoringSafeArea(.all)
                            }
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}
