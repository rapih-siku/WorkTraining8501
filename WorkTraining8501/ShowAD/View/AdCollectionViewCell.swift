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
    
    static let identifier = "\(AdCollectionViewCell.self)"
    
    private var viewModel: AdCollectionViewCellVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setCell(viewModel: AdCollectionViewCellVM?) {
        self.viewModel = viewModel
        adText.text = viewModel?.text
        price.attributedText = viewModel?.price
        viewModel?.loadImage(completion: { image in
            DispatchQueue.main.async {
                self.adImage.image = image
            }
        })
    }
    
    private func setupUI() {
        background.layer.cornerRadius = 5
        background.layer.masksToBounds = true
        background.backgroundColor = .white
    }
}
