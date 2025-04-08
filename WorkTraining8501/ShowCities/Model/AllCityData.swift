//
//  AllCity.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/25.
//

import Foundation

struct AllCityData: Codable {
    let countryList: [Country]
    
    enum CodingKeys: String, CodingKey {
        case countryList = "Country_List"
    }
}

struct Country: Codable {
    let countryName: String
    let cityList: [City]
    
    enum CodingKeys: String, CodingKey {
        case countryName = "Country_Name"
        case cityList = "City_List"
    }
}

struct City: Codable {
    let cityName: String
    
    enum CodingKeys: String, CodingKey {
        case cityName = "City_Name"
    }
}
