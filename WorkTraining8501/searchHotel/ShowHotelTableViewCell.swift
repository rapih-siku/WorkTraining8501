//
//  ShowHotelTableViewCell.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/31.
//

import UIKit

class ShowHotelTableViewCellViewModel {
    
    var hotel: Hotel?
    var mainImageUrlString: String? { return hotel?.imageUrl }
    var trainImageUrlString: String? { return hotel?.addOn[0] }
    var isHot: Bool? { return hotel?.isHot }
    var hotelName: String? { return hotel?.hotelName }
    var hotelGrade: Double? { return hotel?.hotelGrade }
    var overall: String? { return hotel?.overAll }
    var recommendation: String? { return hotel?.recommendation }
    var location: String? { return hotel?.locationName }
    var memberDiscount: String? { return hotel?.memberLabel }
    var price: NSMutableAttributedString {
        let prefix = hotel?.pricePrefix
        let price = hotel?.price
        let suffix = "起"
        
        let affixTextAttributes : [NSAttributedString.Key :Any] = [
            .foregroundColor : UIColor.black,
            .font : UIFont.systemFont(ofSize: 12)
        ]
        let priceAttributes : [NSAttributedString.Key : Any] = [
            .foregroundColor : UIColor.orange,
            . font : UIFont.systemFont(ofSize: 15)
        ]
        
        let prefixText = NSMutableAttributedString(string: prefix ?? "", attributes: affixTextAttributes)
        let priceText = NSMutableAttributedString(string: price ?? "", attributes: priceAttributes)
        let suffixText = NSMutableAttributedString(string: suffix, attributes: affixTextAttributes)
        
        prefixText.append(priceText)
        prefixText.append(suffixText)
        
        return prefixText
    }
    
    init(hotel: Hotel?) {
        self.hotel = hotel
    }
    
    func loadImage(imageUrlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: imageUrlString) else {
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

class ShowHotelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var corner: UIView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var hotMark: UIView!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var starImages: UIStackView!
    @IBOutlet weak var trainImage: UIImageView!
    @IBOutlet weak var overallGradeBackground: UIView!
    @IBOutlet weak var overallGrade: UILabel!
    @IBOutlet weak var recommendationText: UILabel!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var memberLabel: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var memberLabelHeight: NSLayoutConstraint!
    
    static let identifier = "\(ShowHotelTableViewCell.self)"
    
    private var viewModel: ShowHotelTableViewCellViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setCell(viewModel: ShowHotelTableViewCellViewModel?) {
        setupImage(viewModel: viewModel)
        hotMark.isHidden = !(viewModel?.isHot ?? false)
        hotelName.text = viewModel?.hotelName
        overallGrade.text = viewModel?.overall
        recommendationText.text = viewModel?.recommendation
        locationName.text = viewModel?.location
        price.attributedText = viewModel?.price
        
        if viewModel?.memberDiscount != "" {
            memberLabelHeight.constant = 15
            memberLabel.isHidden = false
            memberLabel.text = " \(viewModel?.memberDiscount ?? "") "
        } else {
            memberLabelHeight.constant = 0
            memberLabel.isHidden = true
        }
    }
}

extension ShowHotelTableViewCell {
    func setupUI() {
        corner.layer.cornerRadius = 5
        corner.clipsToBounds = true
        
        background.layer.masksToBounds = false
        background.layer.shadowColor = UIColor.black.cgColor
        background.layer.shadowOpacity = 0.2
        background.layer.shadowOffset = CGSize(width: 0, height: 2)
        background.layer.shadowRadius = 3
        
        hotMark.clipsToBounds = true
        hotMark.layer.cornerRadius = 5
        
        overallGradeBackground.clipsToBounds = true
        overallGradeBackground.layer.cornerRadius = 5
    }
    
    func setupImage(viewModel: ShowHotelTableViewCellViewModel?) {
        viewModel?.loadImage(imageUrlString: viewModel?.mainImageUrlString ?? "", completion: { [weak self] image in
            DispatchQueue.main.async {
                self?.mainImage.image = image
            }
        })
        viewModel?.loadImage(imageUrlString: viewModel?.trainImageUrlString ?? "", completion: { [weak self] image in
            DispatchQueue.main.async {
                self?.trainImage.image = image
            }
        })
        
        let fullStarCount = Int(viewModel?.hotelGrade ?? 0)

        for view in starImages.arrangedSubviews {
            starImages.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        for _ in 0..<fullStarCount {
            let fullStarImageView = UIImageView(image: UIImage(named: "hotel_star_full"))
            self.starImages.addArrangedSubview(fullStarImageView)
        }
        
        if (viewModel?.hotelGrade ?? 0.0).truncatingRemainder(dividingBy: 1) != 0 {
            let halfStarImageView = UIImageView(image: UIImage(named: "hotel_star_half"))
            starImages.addArrangedSubview(halfStarImageView)
        }
    }
}
