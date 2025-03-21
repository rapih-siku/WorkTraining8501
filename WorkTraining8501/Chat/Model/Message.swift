//
//  Message.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/17.
//

import Foundation

struct Message: Codable {
    var name: String
    var time: Date
    var text: String?
    var sticker: String?
}
