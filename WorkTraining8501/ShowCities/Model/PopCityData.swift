//
//  popCity.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/25.
//

import Foundation

struct PopCityData: Codable {
    let moduleItemList: [ModuleItem]
    
    enum CodingKeys: String, CodingKey {
        case moduleItemList = "ModuleItem_List"
    }
}

struct ModuleItem: Codable {
    let itemText: String
    let itemPic: String?
    
    enum CodingKeys: String, CodingKey {
        case itemText = "Item_Text"
        case itemPic = "Pic_Url"
    }
}
