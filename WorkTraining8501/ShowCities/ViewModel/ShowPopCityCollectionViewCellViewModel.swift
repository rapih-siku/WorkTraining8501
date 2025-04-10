//
//  ShowPopCityCollectionViewCellViewModel.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/28.
//

import Foundation
import UIKit

class ShowPopCityCollectionViewCellViewModel {
    
    var title: String { return popCity?.itemText ?? "" }
    var imageString: String? { return popCity?.itemPic ?? "" }
    
    private var popCity: ModuleItem?
    
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
