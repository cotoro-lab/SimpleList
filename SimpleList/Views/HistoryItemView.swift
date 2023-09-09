//
//  HistoryItemView.swift
//  SimpleList
//
//  Created by shuta uto on 2023/08/31.
//

import SwiftUI
import UIKit

struct HistoryItemView: View {
    var HlistItem: HistoryListItemModel;
    
    private let common = CommonClass()
    
    var body: some View {
        GeometryReader{ geometry in
            HStack(spacing: 0){
                ZStack{
                    
                    Rectangle()
                        .fill(Color(UIColor(CustomColors.customMyWhite)))
                        .frame(width: geometry.size.width * 0.15, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)  // 同じ角丸の設定
                                .stroke(Color(UIColor(CustomColors.customGray)), lineWidth: 4)  // 線（ボーダー）の色と太さ
                        )
                        .cornerRadius(15)
                    VStack(spacing: 0){
                        Text(common.convertToMMDD(from: HlistItem.hli_archiveDate))
                            .font(.system(size: 14))
                            .foregroundColor(CustomColors.customGray)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
                        
                        Rectangle()
                            .fill(Color(UIColor(CustomColors.customGray)))
                            .frame(width: geometry.size.width * 0.15, height: 0.5)
                        
                        Text(common.convertToHHMM(from: HlistItem.hli_archiveDate))
                            .font(.system(size: 10))
                            .foregroundColor(CustomColors.customGray)
                            .padding(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 0))
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 5))
                
                ZStack{
                    Rectangle()
                        .fill(Color(UIColor(CustomColors.customMyWhite)))
                        .cornerRadius(15)
                    HStack(spacing: 0){
                        ZStack(alignment: .trailing) {
                            Image(common.getTagImageName(tagid: HlistItem.hli_tagNo))
                                .resizable()
                                .frame(width: geometry.size.width * 0.15)
                            Rectangle()
                                .fill(Color(UIColor(CustomColors.customGray)))
                                .frame(width: 2)
                        }
                        
                        
                        Text(HlistItem.hli_name)
                            .foregroundColor(CustomColors.customGray)
                            .frame(width: geometry.size.width * 0.6, alignment: .leading)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                        
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
}

