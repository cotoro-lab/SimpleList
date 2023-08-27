//
//  BuyItemView.swift
//  ShoppingList
//
//  Created by shuta uto on 2023/08/28.
//

import SwiftUI

struct BuyItemView: View {
    var message: String
    
    var body: some View {
        Text(message)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
    }
}

