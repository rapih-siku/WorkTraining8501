//
//  ShowHotelTableViewCellViewModel.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/4/7.
//

import Foundation
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
