//
//  RegisterViewModel.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/11.
//

import Foundation
import UIKit

class RegisterViewModel {
    
    var errorMessage: ((String) -> Void)?
    var registerSuccess: ((User) -> Void)?
    var registerSuccess2: ((User) -> Void)?
    var sexChanged: ((String) -> Void)?
    var educationChange: ((String) -> Void)?
    
    var isAgreeRule: Bool = false
    
    private var newUser = User(account: "", password: "", education: "大學")
    
    func updateSex(_ sex: String) {
        newUser.sex = sex
        sexChanged?(sex)
    }
    
    func updateEducation(_ education: String) {
        newUser.education = education
        educationChange?(education)
    }
    
    func toggleAgreeRule() {
        isAgreeRule.toggle()
    }
    
    func register(account: String?, password: String?, users: [User]) {
        var users = users
        
        guard let account, !account.isEmpty,
              let password, !password.isEmpty else {
            errorMessage?("帳號或密碼不能為空")
            return
        }
        
        if users.contains(where: { $0.account == account }) {
            errorMessage?("帳號已存在")
            return
        }
        
        if password.count < 8 || password.rangeOfCharacter(from: .letters) == nil || password.rangeOfCharacter(from: .decimalDigits) == nil {
            errorMessage?("密碼請輸入至少8個字元且包含英文及數字")
            return
        }
        
        if newUser.sex == nil {
            errorMessage?("尚未選擇性別")
            return
        }
        
        if isAgreeRule == false {
            errorMessage?("尚未同意使用私人資料")
            return
        }
        
        newUser.account = account
        newUser.password = password
        users.append(newUser)
        saveUserData(users: users)
        
        registerSuccess?(newUser)
        registerSuccess2?(newUser)
    }
    
    func saveUserData(users: [User]) {
        if let usersData = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(usersData, forKey: "users")
            print("🟢users儲存成功！")
        } else {
            print("🔴users儲存失敗！")
        }
    }
    
}
