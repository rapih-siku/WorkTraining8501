//
//  CountrySectionHeaderViewModel.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/28.
//

import Foundation

class CountrySectionHeaderViewModel {
    private var country: Country?
    var countryName: String? { country?.countryName }
    var countryIsExpanded = false
    var showAllCityTableViewCellVMs: [ShowAllCityTableViewCellViewModel] = []
    
    var onTap: (() -> Void)?
    
    init(country: Country) {
        self.country = country
        showAllCityTableViewCellVMs = country.cityList.map { ShowAllCityTableViewCellViewModel(city: $0) }
    }
}
