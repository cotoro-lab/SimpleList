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
    @State private var backgroundColor = UIColor.white
    var body: some View {
        NavigationStack{
            ZStack{
                Color(backgroundColor)
                    .ignoresSafeArea()
                VStack {
                    HStack{
                        Spacer()
                        Button {
                            activie.toggle()
                        } label: {
                            Image(systemName: "clock")
                                .foregroundColor(.gray)
                                .font(Font.system(size:25))
                        }
                    }
                    
                    
                    ScrollView{
                        VStack{
                            BuyItemView(message: "hogehoge")
                        }
                    }
                    Button(action:{
                        
                    }){
                        Image(systemName: "plus.circle")
                            .foregroundColor(.gray)
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

//HistoryView
struct HistoryView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            ZStack{
                Color(.gray)
                    .ignoresSafeArea()
                VStack{
                    Text("History")
                        .font(.title)
                        .foregroundColor(.white)
                    ScrollView{
                        VStack{
                            ForEach(1..<100) {
                                BuyItemView(message: "\($0) hogehoge")
                            }
                        }
                    }
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
                    ).tint(.white)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
