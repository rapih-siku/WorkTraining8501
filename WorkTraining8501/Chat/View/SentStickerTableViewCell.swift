//
//  SentStickerTableViewCell.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/20.
//

import UIKit

class SentStickerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var sticker: UIImageView!
    
    static let reuseIdentifier = "\(SentStickerTableViewCell.self)"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(message: Message) {
        name.text = message.name
        sticker.image = UIImage(named: message.sticker ?? "")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        time.text = formatter.string(from: message.time)
    }
}
