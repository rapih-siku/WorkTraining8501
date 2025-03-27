//
//  LoginViewModel.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/11.
//

import Foundation
import UIKit

class LoginViewModel {
    var errorMessage: ((String) -> Void)?
    var loginSuccessMessage: ((String) -> Void)?
    
    func onTouchLogin(account: String?, password: String?, users: [User]) {
        
        guard let account, !account.isEmpty,
              let password, !password.isEmpty else {
            errorMessage?("帳號或密碼不能為空")
            return
        }
        
        if users.contains(where: { $0.account == account && $0.password == password }) {
            loginSuccessMessage?("登入成功")
        } else {
            errorMessage?("帳號與密碼不符合")
        }
    }
}
