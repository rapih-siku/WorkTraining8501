//
//  ShowPopCityCollectionViewCell.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/26.
//

import UIKit

class ShowPopCityCollectionViewCellVM {
    var popCity: ModuleItem?
    var title: String {
        return popCity?.itemText ?? ""
    }
    var imageString: String? {
        return popCity?.itemPic ?? ""
    }
    
    init (popCity: ModuleItem) {
        self.popCity = popCity
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: imageString ?? "") else {
            completion(UIImage(named: "defaultImage"))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data,
               let image = UIImage(data: data),
               error == nil {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

class ShowPopCityCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    
    private var viewModel: ShowPopCityCollectionViewCellVM?
    
    static let identifier = "\(ShowPopCityCollectionViewCell.self)"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundImage.clipsToBounds = true
        backgroundImage.layer.cornerRadius = 5
    }
    
    func setCell(viewModel: ShowPopCityCollectionViewCellVM?) {
        self.viewModel = viewModel
        cityName.text = viewModel?.title
        viewModel?.loadImage { [weak self] image in
            DispatchQueue.main.async {
                self?.backgroundImage.image = image
            }
        }
    }
}
