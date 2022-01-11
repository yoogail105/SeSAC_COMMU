//
//  DateFormatter+Extension.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/10.
//

import UIKit

extension DateFormatter {
    
    // string: 2021-12-30T10:01:48.503Z
    // date: 2022-01-11 06:32:32 +0000
    
    func fullDateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        return dateFormatter.string(from: date)
    }
    
    func simpleDateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date)
    }
    
    func simpleTimeString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a hh:mm"
        
        return dateFormatter.string(from: date)
    }
    
}

