//
//  ShowAllCityTableViewCellViewModel.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/28.
//

import Foundation

class ShowAllCityTableViewCellViewModel {
    
    var city: City?
    var cityName: String? { return city?.cityName }
    
    init(city: City) {
        self.city = city
    }
}
