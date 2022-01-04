//
//  PostView.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/04.
//

import UIKit
import SnapKit

class PostView: UIView {
    
    let label: UILabel = {
       let label = UILabel()
        label.text = "board뷰"
        label.textColor = .red
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        constraints()
    }
    
    func configure() {
        
    }
    
    func constraints() {
        
        self.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
    }
    
    
}
