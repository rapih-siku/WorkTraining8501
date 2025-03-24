//
//  adCollectionViewCell.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/21.
//

import UIKit



class AdCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var adImage: UIImageView!
    @IBOutlet weak var adText: UILabel!
    @IBOutlet weak var price: UILabel!
    
    static let reuseIdentifier = "\(AdCollectionViewCell.self)"
    
    private var ViewModel: AdCollectionViewCellVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        background.layer.cornerRadius = 5
        background.layer.masksToBounds = true
        background.backgroundColor = .white
    }
    
    func setCell(viewModel: AdCollectionViewCellVM?) {
        self.ViewModel = viewModel
        adText.text = ViewModel?.text
        price.attributedText = ViewModel?.price
        ViewModel?.loadImage(completion: { image in
            DispatchQueue.main.async {
                self.adImage.image = image
            }
        })
    }
}
