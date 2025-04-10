//
//  SelectionTableViewCell.swift
//  Colatour
//
//  Created by Labe on 2025/3/7.
//

import UIKit

class SelectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    static let identifier = "\(SelectionTableViewCell.self)"
    
    private var viewModel: SelectionTableViewCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addButton.tintColor = UIColor(red: 170/255, green: 96/255, blue: 200/255, alpha: 1)
    }
    
    func setCell(viewModel: SelectionTableViewCellViewModel) {
        self.viewModel = viewModel
        title.text = viewModel.title
        count.text = viewModel.count
        
        viewModel.adjustButton(button: subtractButton)
    }
        
    @IBAction func decreaseCount(_ sender: Any) {
        viewModel?.decreaseCount()
    }
    
    @IBAction func increaseCount(_ sender: Any) {
        viewModel?.increaseCount()
    }
}
