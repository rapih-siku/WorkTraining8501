//
//  BottomSheetTableViewCell.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/10.
//

import UIKit

class BottomSheetTableViewCell: UITableViewCell {

    @IBOutlet weak var option: UILabel!
    
    static let reuseIdentifier = "\(BottomSheetTableViewCell.self)"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
