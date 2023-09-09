//
//  CommonClass.swift
//  SimpleList
//
//  Created by shuta uto on 2023/08/30.
//

import Foundation

class CommonClass{
    public let dicTags : [Int: String] = [1: "gray_image", 2: "white_image", 3: "line_image"]
    
    func getTagImageName(tagid: Int) -> String {
        var image_name: String = "gray_image"
        
        if let val = dicTags[tagid]{
            image_name = val;
        }
        
        return image_name;
    }
    
    func getDateTimeNow() -> String{
        var strDatetimeNow: String = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        strDatetimeNow = dateFormatter.string(from: Date())
        
        return strDatetimeNow
    }
    
    // 1ヶ月前日取得
    func getDTLastMonth() -> String{
        var oneMonthAgoString: String = ""
        let hhmmss: String = "000000"
        
        // 現在の日付を取得
        let currentDate = Date()
        
        // カレンダーインスタンスを作成
        let calendar = Calendar.current
        
        // 現在の日付から1ヶ月前の日付を取得
        if let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: currentDate) {
            // DateFormatterを作成してフォーマットを設定
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            
            // 日付を文字列に変換
            oneMonthAgoString = dateFormatter.string(from: oneMonthAgo) + hhmmss
        }
            
        return oneMonthAgoString
    }
    
    func convertToMMDD(from ymdhms: String) -> String {
        // 引数の長さが14文字でない場合はnilを返す
        guard ymdhms.count == 14 else {
            return ""
        }
        
        // 文字列から年月日を抜き出す
        let ymd = String(ymdhms.prefix(8))
        
        // DateFormatterを使って変換
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        guard let date = dateFormatter.date(from: ymd) else {
            return ""
        }
        
        // 新しいフォーマットで日付を出力
        dateFormatter.dateFormat = "M/d"
        return dateFormatter.string(from: date)
    }
    
    func convertToHHMM(from ymdhms: String) -> String {
        // 引数の長さが14文字でない場合はnilを返す
        guard ymdhms.count == 14 else {
            return ""
        }
        
        // 文字列から時と分を抜き出す
        let hhmm = String(ymdhms[ymdhms.index(ymdhms.startIndex, offsetBy: 8)...].prefix(4))
        
        // DateFormatterを使って変換
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HHmm"
        
        guard let date = dateFormatter.date(from: hhmm) else {
            return ""
        }
        
        // 新しいフォーマットで日付を出力
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
