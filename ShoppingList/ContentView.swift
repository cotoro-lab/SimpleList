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
    @State private var backgroundColor = UIColor(CustomColors.customOffWhite)
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationStack{
                ZStack{
                    Color(backgroundColor)
                        .ignoresSafeArea()
                    VStack {
                        HStack{
                            Spacer()
                            Text("Shopping List")
                            .font(.title)
                            .foregroundColor(CustomColors.customGray)
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
                                      
                                        BuyItemView(message: "\($0)hogehoge", tag_id: tag_num)
                                            .frame(width: geometry.size.width * 0.8, height: 45)
                                    }
                                }
                                Spacer()
                            }
                        }
                        Button(action:{
                            
                        }){
                            Image(systemName: "plus.circle")
                                .foregroundColor(CustomColors.customGray)
                                .font(Font.system(size:40))
                        }
                    }
                    .padding()
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
    @State private var backgroundColor = UIColor(CustomColors.customOffWhite)

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
                                            BuyItemView(message: "\($0) hogehoge",tag_id: tag_num)
                                                .frame(width: geometry.size.width * 0.8,height: 45)
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
