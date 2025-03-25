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
    
    private var viewModel: AdCategoryTableViewCellVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    override func layoutSubviews() {
        viewModel?.setupCollectionViewSize(collectionView: ads)
    }
    
    func setCell(viewModel: AdCategoryTableViewCellVM?) {
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
}
