//
//  CountrySectionHeaderViewModel.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/28.
//

import Foundation

class CountrySectionHeaderViewModel {
    var country: Country?
    var countryName: String? { country?.countryName }
    var countryIsExpanded: Bool { country?.isExpanded ?? false }
    
    var onTap: (() -> Void)?
    
    init(country: Country) {
        self.country = country
    }
}
