//
//  AllCityViewModel.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/28.
//

import Foundation

class AllCityViewModel {
    var allCities: [Country] = []
    var allCitiesCount: Int { allCities.count }
    var countrySectionHeaderVMs: [CountrySectionHeaderViewModel] = []
    
    init(allCities: [Country]) {
        self.allCities = allCities
        countrySectionHeaderVMs = allCities.map { CountrySectionHeaderViewModel(country: $0) }
    }
    
    func fetchCityListIsExpanded(at section: Int) -> Bool {
        return allCities[section].isExpanded
    }
    
    func createShowAllCityTableViewCellVM(at indexPath: IndexPath) -> ShowAllCityTableViewCellViewModel {
        let city = allCities[indexPath.section].cityList[indexPath.row]
        return ShowAllCityTableViewCellViewModel(city: city)
    }
}
