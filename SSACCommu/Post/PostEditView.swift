//
//  PostDetailView.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/05.
//

import UIKit
import SnapKit
import RxSwift
import RxKeyboard

class PostEditView: UIView {
    let disposeBag = DisposeBag()
    let textField: UITextField = {
       let textField = UITextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "SSACGray")?.cgColor
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .green
        
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
            $0.top.equalTo(self.layoutMarginsGuide).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(500)
        }
    
    
    RxKeyboard.instance.visibleHeight
        .skip(1)    // 초기 값 버리기
        .drive(onNext: { keyboardVisibleHeight in
            self.textField.snp.updateConstraints {
                        $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(keyboardVisibleHeight)
                    }
        })
        .disposed(by: disposeBag)
    
    
    }
}
