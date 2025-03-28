//
//  PopCityView.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/25.
//

import UIKit

extension PopCityView {
    func setView(viewModel: PopCityViewModel) {
        self.viewModel = viewModel
        showPopCity.reloadData()
    }
}

class PopCityView: UIView {
    
    @IBOutlet weak var toAllCityView: UIButton!
    @IBOutlet weak var showPopCity: UICollectionView!
    
    static let identifier = "PopCityView"
    
    var viewModel: PopCityViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    override func layoutSubviews() {
        updateUI()
    }
    
    @IBAction func tapToAllCity(_ sender: Any) {
        viewModel?.didTapButton?()
    }
}

extension PopCityView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.popCitiesCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowPopCityCollectionViewCell.identifier, for: indexPath) as? ShowPopCityCollectionViewCell else { fatalError() }
        let vm = viewModel?.collectionViewCellVMs[indexPath.row]
        cell.setCell(viewModel: vm)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("點擊了\(viewModel?.popCities[indexPath.row].itemText ?? "")")
    }
}

extension PopCityView {
    
    private func customInit() {
        let nib = UINib(nibName: PopCityView.identifier, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError("\(self)載入失敗") }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        
        setupUI()
    }
    
    private func setupUI() {
        showPopCity.delegate = self
        showPopCity.dataSource = self
        showPopCity.register(UINib(nibName: ShowPopCityCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ShowPopCityCollectionViewCell.identifier)
        showPopCity.isScrollEnabled = false
    }
    
    private func updateUI() {
        let itemSpacing: CGFloat = 10
        let showItemCount: CGFloat = 3
        let sideInset: CGFloat = 20
        guard let flowLayout = showPopCity.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let totalSpacing = (showItemCount - 1) * itemSpacing + sideInset * 2
        let itemWidth = floor((self.bounds.width - totalSpacing) / showItemCount)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 0.8)
        flowLayout.minimumLineSpacing = itemSpacing
        flowLayout.minimumInteritemSpacing = itemSpacing
        flowLayout.sectionInset = UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
        
        toAllCityView.layer.borderWidth = 1
        toAllCityView.layer.borderColor = CGColor(red: 170/255, green: 96/255, blue: 200/255, alpha: 1)
        toAllCityView.layer.cornerRadius = 5
    }
}
