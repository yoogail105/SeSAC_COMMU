//
//  SignInViewModel.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/03.
//

// lala@sessac.com

import Foundation
import RxSwift
import RxRelay



class SignInViewModel {
    
    let userDefaults = UserDefaults.standard
    var emailObserver = BehaviorRelay<String>(value: "")
    var passwordObserver = BehaviorRelay<String>(value: "")
    
    var isValidEmail: Observable<Bool> {
        return emailObserver.map { $0.validateEmail() }
    }
    var isValidPassword: Observable<Bool> {
        return passwordObserver.map { $0.validatePassword() }
    }
    
    var isValidForm: Observable<Bool> {
        return Observable.combineLatest(emailObserver, passwordObserver)
            .map { email, password in
                
                return email.validateEmail() &&  password.validatePassword()
            }
    }
    
    func postUserSignIn(completion: @escaping (APIError?) -> ()) {
        print(#function)
        
        APIService.signIn(email: emailObserver.value, password: passwordObserver.value) { userData, error in
           
            if error != nil {
                completion(error)
            }
            
            print("SignInViewModel 정보:",self.emailObserver.value, self.passwordObserver.value)
            print("SignInViewModel userData:",userData)
            print("SignInViewModel error:",error)
            
            guard let userData = userData else {
                return
            }
            
            self.userDefaults.validToken = true
            self.userDefaults.token = userData.jwt
            self.userDefaults.id = userData.user.id
            self.userDefaults.nickname = userData.user.username
            self.userDefaults.email = userData.user.email
            
            completion(error)
        }
    }
    
}

extension String {
    func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
    
    func validatePassword() -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[~!@#$%^&*]).{8,15}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return predicate.evaluate(with: self)
    }
}

/*
 import Foundation
 import RxSwift
 import RxRelay
 
 
 
 class SignInViewModel {
 
 var input = Input()
 var output = Output()
 let disposeBag = DisposeBag()
 struct Input {
 var email = PublishSubject<String>()
 var password = PublishSubject<String>()
 var tapSignIn = PublishSubject<Void>()
 }
 
 struct Output {
 var enableSignInButton = PublishRelay<Bool>()
 var errorMessage = PublishRelay<String>()
 var goToMain = PublishRelay<Void>()
 }
 
 init() {
 Observable.combineLatest(input.email, input.password)
 .map { !$0.0.isEmpty && !$0.1.isEmpty && $0.0.contains("@") && $0.0.contains(".") && $0.1.count >= 8 }
 .bind(to: output.enableSignInButton)
 .disposed(by: disposeBag)
 
 input.tapSignIn.withLatestFrom(Observable.combineLatest(input.email, input.password)).bind { [weak self] (email, password) in
 guard let self = self else { return }
 if !email.contains("@") || !email.contains(".") {
 self.output.errorMessage.accept("올바른 이메일을 입력해주세요")
 }else if
 password.count < 8 {
 self.output.errorMessage.accept("8자리 이상 비밀번호를 입력해주세요.")
 } else {
 // API 태우기
 self.output.goToMain.accept(())
 }
 }.disposed(by: disposeBag)
 
 }
 }
 */
