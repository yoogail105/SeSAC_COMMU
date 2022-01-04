//
//  SignInViewModel.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/03.
//

import Foundation

class SignInViewModel {
   
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    
    func postUserSignIn(completion: @escaping () -> Void) {
        print(#function)
        
        APIService.signIn(email: email.value, password: password.value) { userData, error in
            print("SignInViewModel 정보:",self.email.value, self.password.value)
            print("SignInViewModel userData:",userData)
            print("SignInViewModel error:",error)
            
            guard let userData = userData else {
                return
            }
            
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.username, forKey: "nickname")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")
            UserDefaults.standard.set(userData.user.confirmed, forKey: "confirmed")
            
            completion()
        }
    }
    
}

/*
var input = Input()
var output = Output()

struct Input {
let email = PublishSubject<String>()
let password = PublishSubject<String>()
let tapSignInButton = PublishSubject<Void>() // 버튼을 누르는 것도 입력
    
}

struct Output {
    let activeSignInButton = PublishRelay<Bool>()
    let errorMessage = PublishRelay<String>()
    let access = PublishRelay<Void>()
}

*/
