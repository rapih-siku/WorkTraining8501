//
//  Hotels.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/31.
//

import Foundation

struct HotelsData: Codable {
    let hotelList: [Hotel]
    
    enum CodingKeys: String, CodingKey {
        case hotelList = "Hotel_List"
    }
}

struct Hotel: Codable {
    let addOn: [String]
    let retailPriceValue: Int
    let recommendation: String
    let locationName: String
    let pricePrefix: String
    let memberLabel: String
    let price: String
    let overAll: String
    let hotelGrade: Double
    let hotelName: String
    let isHot: Bool
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case addOn = "Add_On"
        case retailPriceValue = "TWD_RetailPrice_Value"
        case recommendation = "Recommendation"
        case locationName = "Location_Name"
        case pricePrefix = "Price_Prefix"
        case memberLabel = "Member_Label"
        case price = "TWD_RetailPrice"
        case overAll = "Overall"
        case hotelGrade = "Hotel_Grade"
        case hotelName = "Hotel_Name"
        case isHot = "Is_Hot"
        case imageUrl = "Img_Url"
    }
}
