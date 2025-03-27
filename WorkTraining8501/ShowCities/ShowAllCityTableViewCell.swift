//
//  ShowAllCityTableViewCell.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/26.
//

import UIKit

class ShowAllCityTableViewCellVM {
    var city: City?
    var cityName: String? {
        return city?.cityName
    }
    
    init(city: City) {
        self.city = city
    }
}

class ShowAllCityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    static let identifier = "\(ShowAllCityTableViewCell.self)"
    
    private var viewModel: ShowAllCityTableViewCellVM?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell() {
        title.text = viewModel?.cityName
    }
}
