//
//  CountrySectionView.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/26.
//

import UIKit

extension CountrySectionHeaderView {
    func setView(viewModel: CountrySectionHeaderViewModel) {
        self.viewModel = viewModel
    }
}

class CountrySectionHeaderView: UIView {
    
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var markImage: UIImageView!
    @IBOutlet weak var bottomLine: UIView!
    
    static let identifier = "\(CountrySectionHeaderView.self)"
    
    private var viewModel: CountrySectionHeaderViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
        tapHeader()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
        tapHeader()
    }
    
    func setSectionHeaderView() {
        countryName.text = viewModel?.countryName
        markImage.image = (viewModel?.countryIsExpanded ?? false) ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
        bottomLine.isHidden = viewModel?.countryIsExpanded ?? false
    }
}

extension CountrySectionHeaderView {
    
    private func customInit() {
        let nib = UINib(nibName: CountrySectionHeaderView.identifier, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("\(self)載入失敗")
        }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
    
    private func tapHeader() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapHeader))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapHeader() {
        viewModel?.onTap?()
    }
}
