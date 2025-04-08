//
//  AdCollectionViewCellVM.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/24.
//

import Foundation
import UIKit

class AdCollectionViewCellViewModel {
    
    var adItem: Item?
    var text: String? {
        return adItem?.itemText
    }
    var price: NSMutableAttributedString {
        let priceString = "$\(adItem?.itemPrice ?? 0)"
        let suffixString = "起"
        
        let priceAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.red,
            .font: UIFont.systemFont(ofSize: 12)
        ]
        let suffixAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 10)
        ]
        
        let attributedText = NSMutableAttributedString(string: priceString, attributes: priceAttributes)
        let suffix = NSMutableAttributedString(string: suffixString, attributes: suffixAttributes)
        attributedText.append(suffix)
        
        return attributedText
    }
    var imageUrlString: String? {
        return adItem?.itemPic
    }
    
    init (adItem : Item) {
        self.adItem = adItem
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: imageUrlString ?? "") else {
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
