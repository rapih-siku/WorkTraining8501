//
//  AdCategoryTableViewCellVM.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/21.
//

import Foundation
import UIKit

class AdCategoryTableViewCellVM {
    
    var adModule: Module?
    var title: String? {
        return adModule?.moduleText
    }
    var adItems: [Item]? {
        return adModule?.moduleItems
    }
    var collectionViewCellVMs: [AdCollectionViewCellVM] = []
    
    init(adModule: Module) {
        self.adModule = adModule
        self.collectionViewCellVMs = (self.adItems ?? []).map ({AdCollectionViewCellVM(adItem: $0)})
    }
    
    func setupCollectionViewSize(collectionView: UICollectionView) {
        let itemSpacing: CGFloat = 8
        let showItemCount: CGFloat = 2.5
        let sideInset: CGFloat = 10
        
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let totalSpacing = (showItemCount - 1) * itemSpacing + sideInset * 2
        let itemWidth = floor((collectionView.bounds.width - totalSpacing) / showItemCount)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.estimatedItemSize = .zero
        flowLayout.minimumInteritemSpacing = itemSpacing
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: sideInset)
        
        collectionView.showsHorizontalScrollIndicator = false
    }
}
