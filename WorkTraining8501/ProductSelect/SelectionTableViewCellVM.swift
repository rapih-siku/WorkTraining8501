//
//  SelectionTableViewCellVM.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/17.
//

import Foundation

class SelectionTableViewCellVM {
    var travelerInfo: TravelersInfo?
    
    var onDataUpdated: (() -> Void)?
    
    init(travelersInfo: TravelersInfo? = nil) {
        self.travelerInfo = travelersInfo
    }
    
    func increaseCount() {
        travelerInfo?.count += 1
        onDataUpdated?()
    }
    
    func decreaseCount() {
        travelerInfo?.count -= 1
        onDataUpdated?()
    }
}
