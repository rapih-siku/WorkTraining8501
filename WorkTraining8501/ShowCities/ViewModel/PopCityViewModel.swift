//
//  PopCityViewModel.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/28.
//

import Foundation

class PopCityViewModel {
    var popCities: [ModuleItem] = []
    var popCitiesCount: Int { popCities.count }
    var collectionViewCellVMs: [ShowPopCityCollectionViewCellViewModel] = []
    
    var didTapButton: (() -> Void)?
    
    init(popCityData: [ModuleItem]) {
        self.popCities = popCityData
        self.collectionViewCellVMs = popCityData.map { ShowPopCityCollectionViewCellViewModel(popCity: $0) }
    }
}
