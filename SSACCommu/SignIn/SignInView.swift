//
//  SignInView.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/03.
//

import UIKit
import SnapKit

import UIKit
import SnapKit

class SignInView: UIView {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signButton = UIButton()
    
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
        emailTextField.setupTextField(placeholderText: "이메일 주소")
        passwordTextField.setupTextField(placeholderText: "비밀번호")
        emailTextField.keyboardType = .emailAddress
        signButton.setupButton(title: "입장하기")
        passwordTextField.isSecureTextEntry = true
        
    }
    
    
    func constraints() {
        
        addSubview(stackView)
        
        [emailTextField, passwordTextField, signButton].forEach {
            stackView.addArrangedSubview($0)
        }
        
        
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }

        
        [emailTextField, passwordTextField, signButton].forEach { make in
            make.snp.makeConstraints {
                $0.height.equalTo(44)
                
            }
        }

    }
    
}
