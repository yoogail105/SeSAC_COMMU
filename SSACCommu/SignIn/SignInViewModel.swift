//
//  SignInViewModel.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/03.
//

// lala@sessac.com

import Foundation

class SignInViewModel {
    
    let userDefaults = UserDefaults.standard
    var email: Observable<String> = Observable("")
    var password:Observable<String> = Observable("")
    
    
    func postUserSignIn(completion: @escaping () -> Void) {
        print(#function)
        
        APIService.signIn(email: email.value, password: password.value) { userData, error in
            
            
//            if error ==  {
//                self.showToast(message: "이미 등록된 이메일 입니다.")
//            }
//            
            print("SignInViewModel 정보:",self.email.value, self.password.value)
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
            print("로그인 지금 받은 토큰: \(userData.jwt), 유저디폴트저장되어있는 토큰: \(self.userDefaults.token)")
            
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
