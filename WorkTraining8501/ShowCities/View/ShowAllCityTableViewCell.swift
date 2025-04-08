//
//  ShowAllCityTableViewCell.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/26.
//

import UIKit

class ShowAllCityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    static let identifier = "\(ShowAllCityTableViewCell.self)"
    
    private var viewModel: ShowAllCityTableViewCellViewModel?
    
    func setCell(viewModel: ShowAllCityTableViewCellViewModel?) {
        self.viewModel = viewModel
        title.text = viewModel?.cityName
    }
}
