//
//  SignInViewController.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa

class SignInViewController: BaseViewController {
    
    var mainView = SignInView()
    var viewModel = SignInViewModel()
    let disposeBag = DisposeBag()
   

    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         mainView.emailTextField.becomeFirstResponder()
    }
    


    override func setupNavigationBar() {
        super.setupNavigationBar()
        self.navigationItem.title = "새싹농장 입장하기"
        
    }
    
    
    override func bind() {
        
        mainView.emailTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.emailObserver)
            .disposed(by: disposeBag)
        
        mainView.passwordTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.passwordObserver)
            .disposed(by: disposeBag)
        
        viewModel.isValidEmail
            .map { $0 ? UIColor(named: "SSACGreen") : UIColor.red }
            .bind(to: mainView.emailTextField.rx.textColor)
            .disposed(by: disposeBag)
        
        viewModel.isValidPassword
            .map { $0 ? UIColor(named: "SSACGreen") : UIColor.red }
            .bind(to: mainView.passwordTextField.rx.textColor)
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
        

        self.mainView.signButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        
    }
    
//    @objc func emailTextFieldDidChange(_ textfield: UITextField) {
//        viewModel.emailObserver.value = textfield.text ?? ""
//    }
//
//    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
//        viewModel.passwordObserver.value = textfield.text ?? ""
//    }
    
    @objc func signInButtonClicked() {
        print(#function)
        viewModel.postUserSignIn { error in
            UserDefaults.standard.validToken = true
            let vc = PostViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
