//
//  BuyItemView.swift
//  ShoppingList
//
//  Created by shuta uto on 2023/08/28.
//

import SwiftUI
import UIKit

struct ListItemView: View {
    var listItem: ListItemModel;
    
    
    var body: some View {
        
        GeometryReader{ geometry in
            ZStack{
                Rectangle()
                    .fill(Color(UIColor(CustomColors.customMyWhite)))
                    .cornerRadius(15)
                HStack{
                    ZStack(alignment: .trailing) {
                        Image(ListItemViewModel().getTagImageName(tagid: listItem.listitem_tagno))
                            .resizable()
                            .frame(width: geometry.size.width * 0.2)
                        Rectangle()
                            .fill(Color(UIColor(CustomColors.customGray)))
                            .frame(width: 2)
                    }
                    Text(listItem.listitem_name)
                        .foregroundColor(CustomColors.customGray)
                        .frame(width: geometry.size.width * 0.7, alignment: .leading)
                    
                    Spacer()
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 15)  // 同じ角丸の設定
                        .stroke(Color(UIColor(CustomColors.customGray)), lineWidth: 4)  // 線（ボーダー）の色と太さ
                )
                .cornerRadius(15)
            }
        }
    }
}
