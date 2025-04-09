//
//  BottomSheetTableViewCell.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/10.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {

    @IBOutlet weak var option: UILabel!
    
    static let identifier = "\(OptionsTableViewCell.self)"
    
    private var viewModel: OptionsTableViewCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(viewModel: OptionsTableViewCellViewModel) {
        option.text = viewModel.education
    }
}
