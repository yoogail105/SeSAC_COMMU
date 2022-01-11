//
//  ChangePWViewModel.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/05.
//

import Foundation

class ChangePWViewModel {
    
    let userDefaults = UserDefaults.standard
    var currentPassword: Observable<String> = Observable("")
    var newPassword: Observable<String> = Observable("")
    var confirmNewPassword: Observable<String> = Observable("")
    
    func postChangePassword(currentPassword: String, newPassword: String, confirmNewPassword: String, completion: @escaping () -> Void) {
        print(#function)
        
        APIService.changePW( currentPassword: currentPassword, newPassword: newPassword, confirmNewPassword: confirmNewPassword) { userData, error in
            
            guard userData != nil else {
                return
            }
            
            print("성공")
            completion()
        }
        
    }
}
