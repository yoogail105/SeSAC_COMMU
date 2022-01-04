//
//  SignUpViewModel.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/03.
//
import Foundation

class SignUpViewModel {
   
    var email: Observable<String> = Observable("")
    var userName: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    var confirmPassword: Observable<String> = Observable("")
    
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
