//
//  SelectionTableViewCell.swift
//  Colatour
//
//  Created by Labe on 2025/3/7.
//

import UIKit

class selectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    static let reuseIdentifier = "\(selectionTableViewCell.self)"
    
    private var viewModel: SelectionTableViewCellVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addButton.tintColor = UIColor(red: 170/255, green: 96/255, blue: 200/255, alpha: 1)
    }
    
    func setCell(viewModel: SelectionTableViewCellVM) {
        self.viewModel = viewModel
        title.text = "\(viewModel.travelerInfo?.travelerType ?? "") \(viewModel.travelerInfo?.age ?? "")"
        count.text = "\(viewModel.travelerInfo?.count ?? 0)"
        
        adjustButton()
    }
    
    private func adjustButton() {
        if viewModel?.travelerInfo?.travelerType == "大人" && (viewModel?.travelerInfo?.count ?? 0) <= 1 {
            subtractButton.isEnabled = false
            subtractButton.tintColor = .gray
        } else if
            (viewModel?.travelerInfo?.count ?? 0) <= 0 {
            subtractButton.isEnabled = false
            subtractButton.tintColor = .gray
        } else {
            subtractButton.isEnabled = true
            subtractButton.tintColor = UIColor(red: 170/255, green: 96/255, blue: 200/255, alpha: 1)
        }
    }
    
    @IBAction func decreaseCount(_ sender: Any) {
        viewModel?.decreaseCount()
    }
    
    @IBAction func increaseCount(_ sender: Any) {
        viewModel?.increaseCount()
    }
}
