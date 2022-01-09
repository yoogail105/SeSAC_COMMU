//
//  DateFormatter+Extension.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/10.
//

import UIKit

extension DateFormatter {
    
    // 2021-12-30T10:01:48.503Z
    
    func fullDatetString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd a hh:mm"
        
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
