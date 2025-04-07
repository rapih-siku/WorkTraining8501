//
//  FiltersBottomSheetViewModel.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/4/7.
//

import Foundation

class FiltersBottomSheetViewModel {
    
    var minPrice: CGFloat?
    var maxPrice: CGFloat?
    var sliderMinValue: Int?
    var sliderMaxValue: Int?
    var leftThumbPosition: Double?
    var rightThumbPosition: Double?
    
    var tapFilter: ((Int, Int) -> Void)?
    var setThumbPosition: ((Double, Double) -> Void)?
    
    init(minPrice: Int, maxPrice: Int, leftThumbPosition: Double, rightThumbPosition: Double) {
        self.minPrice = CGFloat(minPrice)
        self.maxPrice = CGFloat(maxPrice)
        self.sliderMinValue = minPrice
        self.sliderMaxValue = maxPrice
        self.leftThumbPosition = leftThumbPosition
        self.rightThumbPosition = rightThumbPosition
    }
}
