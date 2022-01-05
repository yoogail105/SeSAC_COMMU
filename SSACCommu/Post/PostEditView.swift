//
//  PostDetailView.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/05.
//

import UIKit
import SnapKit

class PostEditView: UIView {
    
    let textField: UITextField = {
       let textField = UITextField()
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
        
    }
    
    func constraints() {
        [textField].forEach {
            addSubview($0)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(10)
        
        }
    }
    
    
    
    
}
