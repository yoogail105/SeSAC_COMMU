//
//  UIAlertAction+Extension.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/10.
//

import UIKit


extension UIAlertAction {
    
    func changeGreenColor() {
        self.setValue(UIColor(named: "SSACGreen"), forKey: "titleTextColor")
    }
}
