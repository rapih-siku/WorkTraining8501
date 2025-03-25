//
//  SentMessageTableViewCell.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/17.
//

import UIKit

class SentMessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var message: UILabel!
    
    static let reuseIdentifier = "\(SentMessageTableViewCell.self)"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageBackground.clipsToBounds = true
        messageBackground.layer.cornerRadius = 15
    }
    
    func setCell(message: Message) {
        name.text = message.name
        self.message.text = message.text
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        time.text = formatter.string(from: message.time)
    }
}
