//
//  SignInViewController.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/03.
//

import UIKit

class SignInViewController: BaseViewController {
    
    var mainView = SignInView()
    var viewModel = SignInViewModel()
   
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func setupNavigationBar() {
        super.setupNavigationBar()
        self.navigationItem.title = "새싹농장 입장하기"
        
    }
    
    
    override func bind() {
        viewModel.email.bind { text in
            print(text)
            self.mainView.emailTextField.text = text
        }
        
        viewModel.password.bind { text in
            print(text)
            self.mainView.passwordTextField.text = text
        }
    }
    
    override func addAction() {
        
        self.mainView.emailTextField.addTarget(self, action: #selector(
            emailTextFieldDidChange(_:)), for: .editingChanged)
        
        self.mainView.passwordTextField.addTarget(self, action: #selector(
            passwordTextFieldDidChange(_:)), for: .editingChanged)
        
        self.mainView.signButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func emailTextFieldDidChange(_ textfield: UITextField) {
        viewModel.email.value = textfield.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
    }
    
    @objc func signInButtonClicked() {
        print(#function)
        viewModel.postUserSignIn { 
            UserDefaults.standard.validToken = true
            let vc = PostViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
