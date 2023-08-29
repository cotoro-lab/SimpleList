//
//  ContentView.swift
//  ShoppingList
//
//  Created by shuta uto on 2023/08/27.
//

import SwiftUI

// MainView
struct ContentView: View {
    @State private var activie = false
    @State private var backgroundColor = UIColor(CustomColors.customMyWhite)
    
    // モーダル表示の状態を管理する変数
    @State var showAddModal = false
    
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationStack{
                ZStack{
                    Color(backgroundColor)
                        .ignoresSafeArea()
                    VStack {
                        HStack{
                            Spacer()
                            //                            Text("List")
                            //                            .font(.title)
                            //                            .foregroundColor(CustomColors.customGray)
                            Spacer()
                            Button {
                                activie.toggle()
                            } label: {
                                Image(systemName: "clock")
                                    .foregroundColor(CustomColors.customGray)
                                    .font(Font.system(size:25))
                            }
                        }
                        
                        
                        ScrollView{
                            HStack{
                                Spacer()
                                VStack{
                                    ForEach(1..<20) {
                                        let tag_num: Int32 = Int32(arc4random_uniform(3) + 1)
                                        
                                        ListItemView(message: "\($0)hogehoge", tag_id: tag_num)
                                            .frame(width: geometry.size.width * 0.8, height: 60)
                                    }
                                }
                                Spacer()
                            }
                        }
                        Button(action:{
                            showAddModal = true
                            
                        }){
                            Image(systemName: "plus.circle")
                                .foregroundColor(CustomColors.customGray)
                                .font(Font.system(size:40))
                        }
                                            }
                    .padding()
                    
                    if showAddModal {
                        Color.black.opacity(0.2)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture{
                                self.showAddModal = false
                            }
                        
                        AddItemView(showAddModal: $showAddModal)
                            .frame(width: geometry.size.width * 0.8,height: geometry.size.height * 0.3)
                            .onTapGesture{
                                self.showAddModal = false
                            }
                    }
                }
                .navigationDestination(isPresented: $activie, destination: {
                    HistoryView()
                })
            }
        }
    }
}

//HistoryView
struct HistoryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var backgroundColor = UIColor(CustomColors.customMyWhite)

    var body: some View {
        GeometryReader{ geometry in
            NavigationView {
                ZStack{
                    Color(backgroundColor)
                        .ignoresSafeArea()
                    VStack{
                        Text("History")
                            .font(.title)
                            .foregroundColor(CustomColors.customGray)
                        
                            ScrollView{
                                HStack{
                                    Spacer()
                                    VStack{
                                        ForEach(1..<20) {
                                            let tag_num: Int32 = Int32(arc4random_uniform(3) + 1)
                                            ListItemView(message: "\($0) hogehoge",tag_id: tag_num)
                                                .frame(width: geometry.size.width * 0.8,height: 60)
                                        }
                                    }
                                    Spacer()
                                }
                        }.padding(.bottom)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(
                            action: {
                                dismiss()
                            }, label: {
                                Image(systemName: "arrow.backward.circle")
                                    .font(Font.system(size: 20))
                            }
                        ).tint(CustomColors.customGray)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}