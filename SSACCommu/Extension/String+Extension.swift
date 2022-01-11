//
//  String+Extension.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/11.
//

import Foundation


extension String {
    
    //"2021-12-30T10:01:48.503Z"
    func StringToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
    
    
}
