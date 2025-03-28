//
//  adCategoryTableViewCell.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/21.
//

import UIKit

class AdCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var adsTitle: UILabel!
    @IBOutlet weak var ads: UICollectionView!
    
    static let identifier: String = "\(AdCategoryTableViewCell.self)"
    
    private var viewModel: AdCategoryTableViewCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    override func layoutSubviews() {
        setupCollectionViewSize(collectionView: ads)
    }
    
    func setCell(viewModel: AdCategoryTableViewCellViewModel?) {
        self.viewModel = viewModel
        adsTitle.text = viewModel?.title
    }
}

extension AdCategoryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.adItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdCollectionViewCell.identifier, for: indexPath) as? AdCollectionViewCell else { fatalError() }
        let vm = viewModel?.collectionViewCellVMs[indexPath.row]
        cell.setCell(viewModel: vm)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(viewModel?.adItems?[indexPath.row].itemText ?? ""):$\(viewModel?.adItems?[indexPath.row].itemPrice ?? 0)起")
    }
}

extension AdCategoryTableViewCell {
    
    private func setupUI() {
        ads.delegate = self
        ads.dataSource = self
        
        let adCollectionViewCell = UINib(nibName: AdCollectionViewCell.identifier, bundle: nil)
        ads.register(adCollectionViewCell, forCellWithReuseIdentifier: AdCollectionViewCell.identifier)
    }
    
    private func setupCollectionViewSize(collectionView: UICollectionView) {
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
