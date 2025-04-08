//
//  ShowPopCityCollectionViewCell.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/26.
//

import UIKit

class ShowPopCityCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    
    private var viewModel: ShowPopCityCollectionViewCellViewModel?
    
    static let identifier = "\(ShowPopCityCollectionViewCell.self)"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setCell(viewModel: ShowPopCityCollectionViewCellViewModel?) {
        self.viewModel = viewModel
        cityName.text = viewModel?.title
        viewModel?.loadImage { [weak self] image in
            DispatchQueue.main.async {
                self?.backgroundImage.image = image
            }
        }
    }
}

extension ShowPopCityCollectionViewCell {
    
    private func setupUI() {
        backgroundImage.clipsToBounds = true
        backgroundImage.layer.cornerRadius = 5
    }
}
