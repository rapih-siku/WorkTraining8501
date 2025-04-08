//
//  AllCityViewModel.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/28.
//

import Foundation

class AllCityViewModel {
    private var allCities: [Country] = []
    var countrySectionHeaderVMs: [CountrySectionHeaderViewModel] = []
    
    init(allCities: [Country]) {
        self.allCities = allCities
        countrySectionHeaderVMs = allCities.map { CountrySectionHeaderViewModel(country: $0) }
    }
}
