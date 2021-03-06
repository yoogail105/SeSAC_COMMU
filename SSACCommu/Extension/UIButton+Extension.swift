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
        self.backgroundColor = UIColor(named: "SSACGreen")
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        self.setTitleColor(.white, for: .normal)
    }
    
    func greenButtonImageSize(imageName: String, size: Int) {
        
        let config = UIImage.SymbolConfiguration(pointSize: CGFloat(size), weight: .light, scale: .default)
        let image = UIImage(systemName: imageName, withConfiguration: config)
        self.setImage(image, for: .normal)
        self.tintColor = UIColor(named: "SSACGreen")
    }
    
}
