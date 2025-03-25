//
//  User.swift
//  Colatour
//
//  Created by Labe on 2025/3/5.
//

import Foundation

struct User: Codable {
    var account: String
    var password: String
    var sex: String?
    var education: String?
}
