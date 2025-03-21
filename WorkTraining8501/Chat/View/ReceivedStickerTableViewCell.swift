//
//  ReceivedStickerTableViewCell.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/20.
//

import UIKit

class ReceivedStickerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var sticker: UIImageView!
    
    static let reuseIdentifier = "\(ReceivedStickerTableViewCell.self)"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(message: Message) {
        profileImage.image = UIImage(named: message.name)
        name.text = message.name
        sticker.image = UIImage(named: message.sticker ?? "")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        time.text = formatter.string(from: message.time)
    }
}
