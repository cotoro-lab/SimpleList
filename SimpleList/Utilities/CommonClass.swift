//
//  CommonClass.swift
//  SimpleList
//
//  Created by shuta uto on 2023/08/30.
//

import Foundation

class CommonClass{
    public let dicTags : [Int: String] = [1: "gray_image", 2: "white_image", 3: "line_image"]
    
    func getDateTimeNow() -> String{
        var strDatetimeNow = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        strDatetimeNow = dateFormatter.string(from: Date())
        
        return strDatetimeNow
    }
}
