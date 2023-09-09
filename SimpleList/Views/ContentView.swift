//
//  ContentView.swift
//  ShoppingList
//
//  Created by shuta uto on 2023/08/27.
//

import SwiftUI

// MainView
struct ContentView: View {
    
    var body: some View {
        MainView(listItemViewModel: ListItemViewModel())
            .onAppear(){
                print("アプリが開かれました。")
                DBService.shared.FixTermRemoveRecord()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
