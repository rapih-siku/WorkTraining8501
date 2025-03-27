//
//  AdCategoryTableViewCellVM.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/21.
//

import Foundation
import UIKit

class AdCategoryTableViewCellViewModel {
    
    var adModule: Module?
    var title: String? {
        return adModule?.moduleText
    }
    var adItems: [Item]? {
        return adModule?.moduleItems
    }
    var collectionViewCellVMs: [AdCollectionViewCellViewModel] = []
    
    init(adModule: Module) {
        self.adModule = adModule
        self.collectionViewCellVMs = (self.adItems ?? []).map ({AdCollectionViewCellViewModel(adItem: $0)})
    }
}
