//
//  PopCityViewModel.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/28.
//

import Foundation

class PopCityViewModel {
    private var popCities: [ModuleItem] = []
    var collectionViewCellVMs: [ShowPopCityCollectionViewCellViewModel] = []
    
    var didTapButton: (() -> Void)?
    
    init(popCityData: [ModuleItem]) {
        self.popCities = popCityData
        self.collectionViewCellVMs = popCityData.map { ShowPopCityCollectionViewCellViewModel(popCity: $0) }
    }
}
