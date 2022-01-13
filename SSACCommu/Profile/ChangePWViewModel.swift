//
//  ChangePWViewModel.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/05.
//

import Foundation
import RxSwift
import RxRelay

class ChangePWViewModel {
    
    let userDefaults = UserDefaults.standard
    var currentPasswordObserver = BehaviorRelay<String>(value: "")
    var newPasswordObserver = BehaviorRelay<String>(value: "")
    var confirmNewPasswordObserver = BehaviorRelay<String>(value: "")
    
    var isValidCurrentPassword: Observable<Bool> {
        return currentPasswordObserver.map { $0.validatePassword() }
    }
    
    var isValidNewPassword: Observable<Bool> {
        return Observable.combineLatest(currentPasswordObserver, newPasswordObserver)
            .map { curentPassword, newPassword in
                return newPassword.validatePassword() && curentPassword != newPassword
                
            }
            
    }
    
    var isValidConfirmPassword: Observable<Bool> {
        return Observable.combineLatest(newPasswordObserver, confirmNewPasswordObserver)
            .map { password, confirmPassword in
                return password == confirmPassword
            }
    }
    
    var isValidForm: Observable<Bool> {
        return Observable.combineLatest(currentPasswordObserver, newPasswordObserver, confirmNewPasswordObserver)
            .map { currentPassword, newPassword, confirmNewPassword in
                return currentPassword.validatePassword() && currentPassword.validatePassword() && newPassword == confirmNewPassword
            }
    }
    
    func postChangePassword(currentPassword: String, newPassword: String, confirmNewPassword: String, completion: @escaping (APIError?) -> Void) {
        print(#function)
        
        APIService.changePW( currentPassword: currentPassword, newPassword: newPassword, confirmNewPassword: confirmNewPassword) { userData, error in
            
            
            if error != nil {
                completion(error)
            }
            
            guard userData != nil else {
                return
            }
            
            print("성공")
            
            completion(error)
        }
        
    }
}
