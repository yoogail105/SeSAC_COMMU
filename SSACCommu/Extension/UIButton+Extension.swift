//
//  UIButton+Extension.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/03.
//

import Foundation
import UIKit

extension UIButton {
    func setupButton(title: String) {
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor(named: "SSACColor")
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        self.setTitleColor(.white, for: .normal)
    }
}
