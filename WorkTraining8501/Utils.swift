//
//  Utils.swift
//  Colatour
//
//  Created by Labe on 2025/3/5.
//

import Foundation
import UIKit

// Alert提示
extension UIViewController {
    func showAlert(title: String?, message: String?, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "好的", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true)
    }
}

// UserDefaults讀取資料
extension UIViewController {
    func loadUsers() -> [User] {
        if let savedData = UserDefaults.standard.data(forKey: "users") {
            do {
                return try JSONDecoder().decode([User].self, from: savedData)
            } catch {
                print("🔴錯誤-讀取資料失敗： \(error)")
                return []
            }
        } else {
            return []
        }
    }
}
