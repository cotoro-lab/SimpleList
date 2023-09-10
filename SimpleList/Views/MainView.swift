//
//  MainView.swift
//  SimpleList
//
//  Created by shuta uto on 2023/09/03.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var listItemViewModel : ListItemViewModel
    
    @State private var activie = false
    @State private var backgroundColor = UIColor(CustomColors.customMyWhite)
    @State var showAddModal = false
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationStack{
                ZStack{
                    Color(backgroundColor)
                        .ignoresSafeArea()
                    VStack(spacing: 0) {
                        HStack{
                            Spacer()
                            // 履歴画面表示ボタン
                            Button {
                                activie.toggle()
                            } label: {
                                Image(systemName: "clock")
                                    .foregroundColor(CustomColors.customGray)
                                    .font(Font.system(size:25))
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 20))
                        }
                        
                        ZStack {
                            // アイテムリスト
                            List {
                                ForEach(listItemViewModel.listItems) { item in
                                    ListItemView(listItem: item)
                                        .frame(height: 60)
                                        .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                                        .listRowBackground(CustomColors.customMyWhite)
                                    // 右スワイプでアーカイブ
                                        .swipeActions(edge: .leading) {
                                            Button(role: .destructive) {
                                                // Data Archiving
                                                DBService.shared.ItemArchive(listItemM: item)
                                                listItemViewModel.removeItem(item: item)
                                            } label: {
                                                Image(systemName: "checkmark.square.fill")
                                            }
                                            .tint(CustomColors.customGray)
                                        }
                                    // 左スワイプでデリート
                                        .swipeActions(edge: .trailing) {
                                            Button(role: .destructive) {
                                                // Data Deleting
                                                DBService.shared.ItemDelete(listItemM: item)
                                                listItemViewModel.removeItem(item: item)
                                            } label: {
                                                Image(systemName: "trash.fill")
                                            }.tint(CustomColors.customGray)
                                        }
                                }
                            }
                            .scrollContentBackground(.hidden)
                            .background(CustomColors.customMyWhite)
                            
                            // アイテムリストが0件のときに表示
                            if listItemViewModel.listItems.count == 0 {
                                CustomColors.customMyWhite.edgesIgnoringSafeArea(.all)
                            }
                        }
                        
                        // 追加ボタン
                        Button(action:{
                            showAddModal = true
                        }){
                            Image(systemName: "plus.circle")
                                .foregroundColor(CustomColors.customGray)
                                .font(Font.system(size:40))
                        }
                        
                    }
                    
                    if showAddModal {
                        Color.black.opacity(0.2)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture{
                                self.showAddModal = false
                            }
                        
                        AddItemView(showAddModal: $showAddModal, listItemViewModel: listItemViewModel)
                            .frame(width: geometry.size.width * 0.8,height: 150)
                    }
                }
                .navigationDestination(isPresented: $activie, destination: {
                    HistoryView(HlistItemViewModel: HistoryListItemViewModel())
                })
            }
        }
    }
}

