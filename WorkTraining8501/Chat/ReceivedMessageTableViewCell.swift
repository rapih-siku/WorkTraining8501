//
//  receivedMessageTableViewCell.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/17.
//

import UIKit

class ReceivedMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var message: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBackground.clipsToBounds = true
        messageBackground.layer.cornerRadius = 15
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(message: Message) {
        profileImage.image = UIImage(named: message.name)
        name.text = message.name
        self.message.text = message.text
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        time.text = formatter.string(from: message.time)
        }

}
