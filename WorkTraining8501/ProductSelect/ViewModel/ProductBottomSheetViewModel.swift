//
//  ProductBottomSheetVM.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/17.
//

import Foundation

class ProductBottomSheetViewModel {
    
    var travelersInfos: [TravelersInfo] = []
    var cellVMs: [SelectionTableViewCellViewModel] = []
    
    var sentNewTravelersInfo: (([TravelersInfo]) -> Void)?
    
    init(list: [TravelersInfo]) {
        self.travelersInfos = list
        cellVMs = list.map({SelectionTableViewCellViewModel(travelersInfo: $0)})
    }
    
    func confirmSelection() {
        travelersInfos = cellVMs.compactMap { $0.travelerInfo } // 從cellVM裡取目前的最新資料
        sentNewTravelersInfo?(travelersInfos)
    }
}
