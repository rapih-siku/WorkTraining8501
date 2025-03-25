//
//  AD.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/21.
//

import Foundation

struct AdData: Decodable {
    var moduleLists: [Module]
    
    enum CodingKeys: String, CodingKey {
        case moduleLists = "Module_List"
    }
}

struct Module: Decodable {
    var moduleItems: [Item]
    var moduleText: String
    
    enum CodingKeys: String, CodingKey {
        case moduleItems = "ModuleItem_List"
        case moduleText = "Module_Text"
    }
}

struct Item: Decodable {
    var itemPrice: Int
    var itemText: String
    var itemPic: String?
    
    enum CodingKeys: String, CodingKey {
        case itemPrice = "Item_Price"
        case itemText = "Item_Text"
        case itemPic = "Pic_Url"
    }
}
