//
//  ChangePWViewController.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/05.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ChangePWViewController: BaseViewController {
    
    var mainView = ChangePWView()
    var viewModel = ChangePWViewModel()
    let disposeBag = DisposeBag()
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
     

    }
    
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        self.navigationItem.title = "비밀번호 변경하기"
    }
    
    override func bind() {
        
        mainView.currentPasswordTextField.rx.text.map { $0 ?? ""}
        .bind(to: viewModel.currentPasswordObserver)
        .disposed(by: disposeBag)
        
        mainView.newPasswordTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.newPasswordObserver)
            .disposed(by: disposeBag)
        
        mainView.confirmNewPasswordTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.confirmNewPasswordObserver)
            .disposed(by: disposeBag)
        
        mainView.currentPasswordTextField.rx.text.orEmpty
            .subscribe(onNext: {
                self.limitCurrentPasswordTextField($0)
            })
            .disposed(by: disposeBag)
        
        mainView.newPasswordTextField.rx.text.orEmpty
            .subscribe(onNext: {
                self.limitNewPasswordTextField($0)
            })
            .disposed(by: disposeBag)
        
        mainView.confirmNewPasswordTextField.rx.text.orEmpty
            .subscribe(onNext: {
                self.limitConfirmNewPasswordTextField($0)
            })
            .disposed(by: disposeBag)
        
        
        viewModel.isValidCurrentPassword
            .map { $0 ? UIColor(named: "SSACGreen") : UIColor.red }
            .bind(to: mainView.currentPasswordTextField.rx.textColor)
            .disposed(by: disposeBag)
        
        viewModel.isValidNewPassword
            .map { $0 ? UIColor(named: "SSACGreen") : UIColor.red }
            .bind(to: mainView.newPasswordTextField.rx.textColor)
            .disposed(by: disposeBag)
        
        viewModel.isValidConfirmPassword
            .map { $0 ? UIColor(named: "SSACGreen") : UIColor.red }
            .bind(to: mainView.confirmNewPasswordTextField.rx.textColor)
            .disposed(by: disposeBag)
        
        viewModel.isValidForm
            .map{ $0 ? 1.0 : 0.3}
            .bind(to: mainView.changeButton.rx.alpha)
            .disposed(by: disposeBag)
    }
    
    override func addAction() {
        
        self.mainView.changeButton.addTarget(self, action: #selector(changeButtonClicked), for: .touchUpInside)
        self.mainView.logoutButton.addTarget(self, action: #selector(logoutButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func changeButtonClicked() {
        print("비밀번호 변경하기 버튼 클릭")

        viewModel.postChangePassword(currentPassword: mainView.currentPasswordTextField.text!, newPassword: mainView.newPasswordTextField.text!, confirmNewPassword: mainView.confirmNewPasswordTextField.text!) { error in
            
            if error != nil {
                self.makeAlertWithoutCancel(message: "현재 비밀번호를 정확하게 입력해주세요😲", okTitle: "확인", okAction: nil)
            } else {
                self.makeAlertWithoutCancel(message: "비밀번호가 변경되었습니다! 다시 로그인을 해주세요😇", okTitle: "확인") { _ in
                    self.backToMain()
                }
            }
            
            
            
        }
        
    }
    @objc func logoutButtonClicked() {
        
        self.makeAlert(message: "로그아웃 하시겠습니까?", okTitle: "로그아웃") { _ in
            // userDefaults 정보 지우기
            UserDefaults.standard.reset()
            print("지웠다:",UserDefaults.standard.validToken, UserDefaults.standard.id)
            
            let vc = MainViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
     
    }
    
    private func limitCurrentPasswordTextField(_ password: String) {
        if password.count > 15 {
            let index = password.index(password.startIndex, offsetBy: 15)
            mainView.currentPasswordTextField.text = String(password[..<index])
        }
    }
    
    private func limitNewPasswordTextField(_ password: String) {
        if password.count > 15 {
            let index = password.index(password.startIndex, offsetBy: 15)
            mainView.newPasswordTextField.text = String(password[..<index])
        }
    }
    
    private func limitConfirmNewPasswordTextField(_ password: String) {
        if password.count > 15 {
            let index = password.index(password.startIndex, offsetBy: 15)
            mainView.confirmNewPasswordTextField.text = String(password[..<index])
        }
    }
}
