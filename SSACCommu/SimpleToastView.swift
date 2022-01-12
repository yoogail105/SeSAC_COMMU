//
//  SimpleToastView.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/12.
//

import UIKit
import SnapKit

open class SimpleToastView: UIView {
    
    let message: UILabel = {
        let label = UILabel()
        label.backgroundColor = .darkGray.withAlphaComponent(0.7)
        label.text = "저장되었습니다."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constraints()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
        
        
    }
    
    func constraints() {
        
       addSubview(message)
            
        message.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(44)
        }
    }
}
