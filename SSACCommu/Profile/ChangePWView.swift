//
//  ChangePWView.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/05.
//

import Foundation
import UIKit
import SnapKit

class ChangePWView: UIView {
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let currentPasswordTextField = UITextField()
    let newPasswordTextField = UITextField()
    let confirmNewPasswordTextField = UITextField()
    let changeButton = UIButton()
    
    let logoutButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 44, weight: .light, scale: .default)
        let image = UIImage(systemName: "person.crop.circle.badge.xmark", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(named: "SSACGreen")
        return button
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
        currentPasswordTextField.setupTextField(placeholderText: "현재 비밀번호")
        newPasswordTextField.setupTextField(placeholderText: "새로운 비밀번호(대, 소문자, 숫자, 특수문자(!@#$%^)를 모두 포함한 8~15자리)")
        confirmNewPasswordTextField.setupTextField(placeholderText: "새로운 비밀번호 확인")
        
        changeButton.setupButton(title: "변경하기")
        
        confirmNewPasswordTextField.isSecureTextEntry = true
        newPasswordTextField.isSecureTextEntry = true
        currentPasswordTextField.isSecureTextEntry = true
    }
    
    
    func constraints() {
        
        addSubview(stackView)
        addSubview(logoutButton)
        
        [currentPasswordTextField, newPasswordTextField, confirmNewPasswordTextField, changeButton].forEach {
            stackView.addArrangedSubview($0)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        
        [currentPasswordTextField, newPasswordTextField, confirmNewPasswordTextField, changeButton].forEach { make in
            make.snp.makeConstraints {
                $0.height.equalTo(44)
                
            }
        }
        
        logoutButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-30)
            $0.trailing.equalToSuperview().offset(-30)
            
        }
        
        
    }
    
}
