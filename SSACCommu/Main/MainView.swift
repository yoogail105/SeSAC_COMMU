//
//  MainView.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/03.
//

import UIKit
import SnapKit

class MainView: UIView {

    
    let centerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let footerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let sessacImage = UIImageView()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let signUpButton = UIButton()
    let signInLabel = UILabel()
    let signInButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        setupConstraints()
    }

    
    func configure() {
        sessacImage.image = UIImage(named: "logo_ssac_clear")
        
        titleLabel.text = "당신 근처의 새싹농장"
        titleLabel.textColor = .label
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        subTitleLabel.text = "iOS 지식부터 바람의 나라까지\n지금 SeSAC에서 함께해보세요!"
        subTitleLabel.numberOfLines = 0
        subTitleLabel.textAlignment = .center
        subTitleLabel.textColor = .label
        subTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        
        signUpButton.setTitle("시작하기", for: .normal)
        signUpButton.setupButton(title: "시작하기")
        
        signInLabel.text = "이미 계정이 있나요?"
        signInLabel.font = UIFont.systemFont(ofSize: 10)
        signInLabel.textColor = .lightGray
        
        signInButton.setTitle("로그인", for: .normal)
        //signInButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        signInButton.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        signInButton.setTitleColor(UIColor(named: "SSACColor"), for: .normal)
    }
    
    
    func setupConstraints() {
        
        [sessacImage, titleLabel, subTitleLabel].forEach {
            centerStackView.addArrangedSubview($0)
        }
        
        [signInLabel, signInButton].forEach {
            footerStackView.addArrangedSubview($0)
        }
        
        [centerStackView, signUpButton, footerStackView].forEach {
            addSubview($0)
        }
    
        centerStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(200)
        }
        
        sessacImage.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.width.equalTo(100)
        }
        
//        titleLabel.snp.makeConstraints {
//
//        }
//
//        subTitleLabel.snp.makeConstraints {
//        }
        
        footerStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.centerX.equalToSuperview()
        }
        
//        signInLabel.snp.makeConstraints {
//
//        }
//
//        signInButton.snp.makeConstraints {
//
//        }
        
        signUpButton.snp.makeConstraints {
            $0.bottom.equalTo(footerStackView.snp.top).offset(-20)
            $0.height.equalTo(44)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
}
