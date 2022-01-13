//
//  SignUpViewModel.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/03.
//
import Foundation
import RxSwift
import RxRelay


class SignUpViewModel {
    
    var userNameObserver = BehaviorRelay<String>(value: "")
    var emailObserver = BehaviorRelay<String>(value: "")
    var passwordObserver = BehaviorRelay<String>(value: "")
    var confirmPasswordObserver = BehaviorRelay<String>(value: "")
    
    var isValidNickname: Observable<Bool> {
        return userNameObserver.map { $0.count > 1 }
    }
    
    var isValidEmail: Observable<Bool> {
        return emailObserver.map { $0.validateEmail() }
    }
    var isValidPassword: Observable<Bool> {
        return passwordObserver.map { $0.validatePassword() }
    }
    
//    let buttonEnableEvent = Driver.combineLatest(idEvent, passEvent)
//        .map { !$0.0.isEmpty && !$0.1.isEmpty }
    
    var isValidConfirmPassword: Observable<Bool> {
        return Observable.combineLatest(passwordObserver, confirmPasswordObserver)
            .map { password, confirmPassword in
                return password == confirmPassword
            }
    }
    
    var isValidForm: Observable<Bool> {
        return Observable.combineLatest(userNameObserver, emailObserver, passwordObserver, confirmPasswordObserver)
            .map { userName, email, password, confirmPassword in
                return userName.count > 1 && email.validateEmail() && password.validatePassword() && password == confirmPassword
            }
    }

    
    func postUserSignUp(completion: @escaping (APIError?) -> Void) {
        print(#function)
        
        APIService.signUp(userName: userNameObserver.value, email: emailObserver.value, password: passwordObserver.value) { userData, error in
            
            if error != nil {
                completion(error)
            }
            guard let userData = userData else {
                return
            }
            
            print("SignUpViewModel", userData)
            completion(error)

        }
    }
    
}
