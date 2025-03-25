//
//  StickerCollectionViewCell.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/19.
//

import UIKit

class StickerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sticker: UIImageView!
    
    static let reuseIdentifier = "\(StickerCollectionViewCell.self)"
    
    func setCell(stickerName: String) {
        let image = UIImage(named: stickerName)
        sticker.image = image
        sticker.accessibilityIdentifier = stickerName
    }
    
    func setCellSize(collectionView: UICollectionView) {
        let itemSpace: Double = 5
        let columnsCount: Double = 3
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width = floor((collectionView.bounds.width - itemSpace * (columnsCount - 1)) / columnsCount)
        flowLayout.itemSize = CGSize(width: width, height: width)
        flowLayout.estimatedItemSize = .zero
        flowLayout.minimumLineSpacing = itemSpace
        flowLayout.minimumInteritemSpacing = itemSpace
    }
}
