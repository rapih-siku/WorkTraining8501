//
//  CountrySectionView.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/26.
//

import UIKit

class CountrySectionHeaderViewModel {
    var country: Country?
    var countryName: String? {
        return country?.countryName
    }
}

class CountrySectionHeaderView: UIView {

    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var markIsExpanded: UIButton!
    
    

}
