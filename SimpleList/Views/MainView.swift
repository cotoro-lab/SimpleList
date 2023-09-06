//
//  MainView.swift
//  SimpleList
//
//  Created by shuta uto on 2023/09/03.
//

import SwiftUI

struct MainView: View {
    
    @State private var activie = false
    @State private var backgroundColor = UIColor(CustomColors.customMyWhite)
    @ObservedObject var listItemViewModel : ListItemViewModel
    
    // モーダル表示の状態を管理する変数
    @State var showAddModal = false
    
    // スワイプ用
    @State var items = Array(1...20)
    
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationStack{
                ZStack{
                    Color(backgroundColor)
                        .ignoresSafeArea()
                    VStack(spacing: 0) {
                        HStack{
                            Spacer()
                            Button {
                                activie.toggle()
                            } label: {
                                Image(systemName: "clock")
                                    .foregroundColor(CustomColors.customGray)
                                    .font(Font.system(size:25))
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 20))
                        }
                        
                        List {
                            ForEach(listItemViewModel.listItems) { item in
                                ListItemView(listItem: item)
                                    .frame(height: 60)
                                    .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                                    .listRowBackground(CustomColors.customMyWhite)
                                    .swipeActions(edge: .leading) {
                                        Button(role: .destructive) {
                                            print("flag action.")
                                        } label: {
                                            Image(systemName: "checkmark.square.fill")
                                        }
                                        .tint(CustomColors.customGray)
                                    }
                                    .swipeActions(edge: .trailing) {
                                        Button(role: .destructive) {
                                            print("delete action.")
                                        } label: {
                                            Image(systemName: "trash.fill")
                                        }.tint(CustomColors.customGray)
                                    }
                                
                            }
                        }
                        .scrollContentBackground(.hidden)
                        
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
                        
                        AddItemView(showAddModal: $showAddModal)
                            .frame(width: geometry.size.width * 0.8,height: 150)
                        
                    }
                }
                .navigationDestination(isPresented: $activie, destination: {
                    HistoryView()
                })
            }
        }
    }
}

