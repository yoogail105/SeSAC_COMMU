//
//  UIAlertAction+Extension.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/10.
//

import UIKit


extension UIAlertAction {
    
    func greenAlertText() {
        self.setValue(UIColor(named: "SSACGreen"), forKey: "titleTextColor")
    }
    
    func redAlertText() {
        self.setValue(UIColor.red, forKey: "titleTextColor")
    }
}
