//
//  SignUpViewController.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/03.
//

import UIKit
import RxSwift

class SignUpViewController: BaseViewController {
    
    var mainView = SignUpView()
    var viewModel = SignUpViewModel()
    
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

        viewModel.email.bind { text in
            print(text)
            self.mainView.emailTextField.text = text
        }
        
        viewModel.userName.bind { text in
            print(text)
            self.mainView.userNameTextField.text = text
        }

        viewModel.password.bind { text in
            print(text)
            self.mainView.passwordTextField.text = text
        }
        
        viewModel.confirmPassword.bind { text in
            print(text)
            self.mainView.confirmPasswordTextField.text = text
        }
        
    }
    
    override func addAction() {
        
        self.mainView.emailTextField.addTarget(self, action: #selector(
            emailTextFieldDidChange(_:)), for: .editingChanged)
        
        self.mainView.userNameTextField.addTarget(self, action: #selector(
            userNameTextFieldDidChange(_:)), for: .editingChanged)
        
        self.mainView.passwordTextField.addTarget(self, action: #selector(
            passwordTextFieldDidChange(_:)), for: .editingChanged)
        
        self.mainView.confirmPasswordTextField.addTarget(self, action: #selector(
            confirmPasswordTextFieldDidChange(_:)), for: .editingChanged)
        
        self.mainView.signButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    }
    
    @objc func emailTextFieldDidChange(_ textfield: UITextField) {
        viewModel.email.value = textfield.text ?? ""
    }
    
    @objc func userNameTextFieldDidChange(_ textfield: UITextField) {
        viewModel.userName.value = textfield.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
    }
    
    @objc func confirmPasswordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.confirmPassword.value = textfield.text ?? ""
    }
    
    
    
    @objc func signInButtonClicked() {
        print(#function)
        viewModel.postUserSignUp {
    
                self.navigationController?.popViewController(animated: true)
        
        }
    }
}

