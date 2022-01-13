//
//  SignUpViewController.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: BaseViewController {
    
    var mainView = SignUpView()
    var viewModel = SignUpViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        mainView.emailTextField.becomeFirstResponder()
        
    }
    
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        self.navigationItem.title = "새싹농장 가입하기"
    }
    
    override func bind() {
        
        mainView.userNameTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.userNameObserver)
            .disposed(by: disposeBag)
        
        mainView.emailTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.emailObserver)
            .disposed(by: disposeBag)
        
        mainView.passwordTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.passwordObserver)
            .disposed(by: disposeBag)
        
        mainView.confirmPasswordTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.confirmPasswordObserver)
            .disposed(by: disposeBag)
        
        mainView.userNameTextField.rx.text.orEmpty
            .subscribe(onNext: {
                self.limitNickname($0)
            })
            .disposed(by: disposeBag)
        
        viewModel.isValidNickname
            .map { $0 ? UIColor(named: "SSACGreen") : UIColor.red }
            .bind(to: mainView.userNameTextField.rx.textColor)
            .disposed(by: disposeBag)
        
        viewModel.isValidEmail
            .map { $0 ? UIColor(named: "SSACGreen") : UIColor.red }
            .bind(to: mainView.emailTextField.rx.textColor)
            .disposed(by: disposeBag)
        
        viewModel.isValidPassword
            .map { $0 ? UIColor(named: "SSACGreen") : UIColor.red }
            .bind(to: mainView.passwordTextField.rx.textColor)
            .disposed(by: disposeBag)
        
        viewModel.isValidConfirmPassword
            .map { $0 ? UIColor(named: "SSACGreen") : UIColor.red }
            .bind(to: mainView.confirmPasswordTextField.rx.textColor)
            .disposed(by: disposeBag)
        
        viewModel.isValidForm
            .bind(to: mainView.signButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isValidForm
            .map{ $0 ? 1.0 : 0.3}
            .bind(to: mainView.signButton.rx.alpha)
            .disposed(by: disposeBag)
        
        
        
    }
    
    override func addAction() {
        
        //        self.mainView.emailTextField.addTarget(self, action: #selector(
        //            emailTextFieldDidChange(_:)), for: .editingChanged)
        //
        //        self.mainView.userNameTextField.addTarget(self, action: #selector(
        //            userNameTextFieldDidChange(_:)), for: .editingChanged)
        //
        //        self.mainView.passwordTextField.addTarget(self, action: #selector(
        //            passwordTextFieldDidChange(_:)), for: .editingChanged)
        //
        //        self.mainView.confirmPasswordTextField.addTarget(self, action: #selector(
        //            confirmPasswordTextFieldDidChange(_:)), for: .editingChanged)
        
        self.mainView.signButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    }
    
    //    @objc func emailTextFieldDidChange(_ textfield: UITextField) {
    //        viewModel.email.value = textfield.text ?? ""
    //    }
    //
    //    @objc func userNameTextFieldDidChange(_ textfield: UITextField) {
    //        viewModel.userName.value = textfield.text ?? ""
    //    }
    //
    //    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
    //        viewModel.password.value = textfield.text ?? ""
    //    }
    //
    //    @objc func confirmPasswordTextFieldDidChange(_ textfield: UITextField) {
    //        viewModel.confirmPassword.value = textfield.text ?? ""
    //    }
    
    
    
    @objc func signInButtonClicked() {
        print(#function)
        viewModel.postUserSignUp { error in
            if error != nil {
                self.makeAlertWithoutCancel(message: "이미 가입되어 있는 아이디입니다😲", okTitle: "확인", okAction: nil)
            } else {
                
                self.makeAlertWithoutCancel(message: "가입이 완료되었습니다!\n 로그인을  해주세요😇", okTitle: "확인") { _ in
                    self.navigationController?.popViewController(animated: true)
                    
                }
               
                
            }
            
        }
    }
    
    private func limitNickname(_ userName: String) {
        if userName.count > 8 {
            let index = userName.index(userName.startIndex, offsetBy: 8)
            mainView.userNameTextField.text = String(userName[..<index])
        }
    }
    
    private func checkUserNameCount(_ userName: String) -> Bool {
        return userName.count > 8
    }
}

