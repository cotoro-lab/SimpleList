//
//  HistoryItemView.swift
//  SimpleList
//
//  Created by shuta uto on 2023/08/31.
//

import SwiftUI
import UIKit

struct HistoryItemView: View {
    var message: String
    var tag_id: Int32
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Rectangle()
                    .fill(Color(UIColor(CustomColors.customMyWhite)))
                    .cornerRadius(15)
                HStack(spacing: 0){
                    ZStack(alignment: .trailing) {
                        switch tag_id {
                            case 1:
                                Image("gray_image")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.2)
                            case 2:
                                Image("white_image")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.2)
                            case 3:
                                Image("line_image")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.2)
                            default:
                                Image("line_image")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.2)
                        }
                        Rectangle()
                            .fill(Color(UIColor(CustomColors.customGray)))
                            .frame(width: 2)
                    }
                    
                    ZStack{
                        
                        Rectangle()
                            .fill(Color(UIColor(CustomColors.customMyWhite)))
                            .frame(width: geometry.size.width * 0.2, alignment: .leading)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)  // 同じ角丸の設定
                                    .stroke(Color(UIColor(CustomColors.customGray)), lineWidth: 2)  // 線（ボーダー）の色と太さ
                            )
                            .cornerRadius(15)
                        VStack(spacing: 0){
                            Text("8/12")
                                .font(.system(size: 23))
                                .foregroundColor(CustomColors.customGray)
                            
                            Rectangle()
                            .fill(Color(UIColor(CustomColors.customGray)))
                            .frame(height: 0.5)
                            
                            Text("9:05")
                                .font(.system(size: 10))
                                .foregroundColor(CustomColors.customGray)
                        }
                    }
                    .padding(EdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 5))
                    
                    Text(message)
                        .foregroundColor(CustomColors.customGray)
                        .frame(width: geometry.size.width * 0.6, alignment: .leading)
                    
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
