//
//  HistoryView.swift
//  SimpleList
//
//  Created by shuta uto on 2023/09/03.
//

import SwiftUI

//HistoryView
struct HistoryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var backgroundColor = UIColor(CustomColors.customMyWhite)

    var body: some View {
        GeometryReader{ geometry in
            NavigationStack {
                ZStack{
                    Color(backgroundColor)
                        .ignoresSafeArea()
                    VStack{
                        HStack{
                            Button(
                                action: {
                                    dismiss()
                                }, label: {
                                    Image(systemName: "arrow.backward.circle")
                                        .font(Font.system(size: 25))
                                }
                            )
                            .tint(CustomColors.customGray)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: -45))
                            
                            Spacer()
                            Text("History")
                                .font(.title)
                                .foregroundColor(CustomColors.customGray)
                                .frame(maxWidth: .infinity )
                            Spacer()
                        }
                        
                        
                        ScrollView{
                            HStack{
                                Spacer()
                                VStack{
                                    ForEach(1..<20) {
                                        let tag_num: Int32 = Int32(arc4random_uniform(3) + 1)
                                        HistoryItemView(message: "\($0) hogehoge",tag_id: tag_num)
                                            .frame(width: geometry.size.width * 0.8,height: 60)
                                    }
                                }
                                Spacer()
                            }
                        }.padding(.bottom)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

