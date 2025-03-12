//
//  SelectionTableViewCell.swift
//  Colatour
//
//  Created by Labe on 2025/3/7.
//

import UIKit

class ProductCustomizationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    static let reuseIdentifier = "\(ProductCustomizationTableViewCell.self)"
    var countChanged: ((Int, Int) -> Void)?
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        adjustButtonColor()
    }
    
    func adjustButtonColor() {
        guard let count = Int(count.text ?? "0") else { return }
        
        if count == 0 {
            subtractButton.tintColor = .gray
            subtractButton.isEnabled = false
        } else {
            subtractButton.tintColor = UIColor(red: 170/255, green: 96/255, blue: 200/255, alpha: 1)
            subtractButton.isEnabled = true
        }
        
        if title.text == "大人(12+)" {
            if count <= 1 {
                subtractButton.tintColor = .gray
                subtractButton.isEnabled = false
            }
        }
        
        addButton.tintColor = UIColor(red: 170/255, green: 96/255, blue: 200/255, alpha: 1)
    }
    
    @IBAction func adjustCount(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            var currentCount = Int(count.text ?? "0") ?? 0
            if currentCount > 0 {
                currentCount -= 1
                count.text = "\(currentCount)"
            }
            countChanged?(index, currentCount)
        case 1:
            var currentCount = Int(count.text ?? "0") ?? 0
            currentCount += 1
            count.text = "\(currentCount)"
            countChanged?(index, currentCount)
        default:
            break
        }
        
        adjustButtonColor()
    }
}
