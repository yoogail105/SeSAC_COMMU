//
//  SignUpView.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/03.
//

import UIKit
import SnapKit

class SignUpView: UIView {

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let emailTextField = UITextField()
    let userNameTextField = UITextField()
    let passwordTextField = UITextField()
    let confirmPasswordTextField = UITextField()
    let signButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constraints()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    
    func configure() {
        emailTextField.setupTextField(placeholderText: "이메일 주소")
        userNameTextField.setupTextField(placeholderText: "닉네임")
        passwordTextField.setupTextField(placeholderText: "비밀번호")
        confirmPasswordTextField.setupTextField(placeholderText: "비밀번호 확인")
        signButton.setupButton(title: "가입하기")
        emailTextField.keyboardType = .emailAddress
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
    }
    
    
    func constraints() {
        
        addSubview(stackView)
        
        [emailTextField, userNameTextField, passwordTextField, confirmPasswordTextField, signButton].forEach {
            stackView.addArrangedSubview($0)
        }
        
        
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }

        
        [emailTextField, userNameTextField, passwordTextField, confirmPasswordTextField, signButton].forEach { make in
            make.snp.makeConstraints {
                $0.height.equalTo(44)
                
            }
        }

    }
    
}
