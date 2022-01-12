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
    
    var emailObserver = BehaviorRelay<String>(value: "")
    var userNameObserver = BehaviorRelay<String>(value: "")
    var passwordObserver = BehaviorRelay<String>(value: "")
    var confirmPasswordObserver = BehaviorRelay<String>(value: "")
    
    func postUserSignUp(completion: @escaping () -> Void) {
        print(#function)
        
        APIService.signUp(userName: userName.value, email: email.value, password: password.value) { userData, error in
            
            guard let userData = userData else {
                return
            }
            
            print("SignUpViewModel", userData)
            completion()

        }
    }
    
}
