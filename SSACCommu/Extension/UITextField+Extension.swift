//
//  UITextField+Extension.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/03.
//

import Foundation
import UIKit

extension UITextField {
    
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
    
    func setupTextField(placeholderText: String) {
        
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor(named: "SSACGray")?.cgColor
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.cornerRadius = 5
        self.placeholder = placeholderText
        self.setPlaceholder(color: .lightGray)
        self.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        self.addLeftPadding()
       
    }
    
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
      }
    
}
