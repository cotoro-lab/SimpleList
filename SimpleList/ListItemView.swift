//
//  BuyItemView.swift
//  ShoppingList
//
//  Created by shuta uto on 2023/08/28.
//

import SwiftUI
import UIKit

struct ListItemView: View {
    var message: String
    var tag_id: Int32
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Rectangle()
                    .fill(Color(UIColor(CustomColors.customMyWhite)))
                    .cornerRadius(15)
                HStack{
                    ZStack(alignment: .trailing) {
                        switch tag_id {
                        case 1:
                            Image("black_image")
                                .resizable()
                                .frame(width: geometry.size.width * 0.2)
                        case 2:
                            Image("white_image")
                                .resizable()
                                .frame(width: geometry.size.width * 0.2)
                        case 3:
                            Image("diagonal_line_image")
                                .resizable()
                                .frame(width: geometry.size.width * 0.2)
                        default:
                            Image("diagonal_line_image")
                                .resizable()
                                .frame(width: geometry.size.width * 0.2)
                        }
                        Rectangle()
                            .fill(Color(UIColor(CustomColors.customGray)))
                            .frame(width: 3)
                    }
                    Text(message)
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
