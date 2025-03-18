//
//  ProductViewModel.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/12.
//

import Foundation

class ProductVM {
    
    var currentTravelersInfos = [
        TravelersInfo(travelerType: "大人",age: "(12+)", count: 1),
        TravelersInfo(travelerType: "小孩", age: "(2-11)", count: 0),
        TravelersInfo(travelerType: "嬰兒",age: "(<2)", count: 0)
    ]
    
    func productCustomizationTitle() -> String {
        let title = currentTravelersInfos
            .map { "\($0.count)\($0.travelerType)" }
            .joined(separator: " ")
        return "旅遊人數\n" + title
    }
}
