//
//  AllCityView.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/26.
//

import UIKit

class AllCityVM {
    var allCities: [Country] = []
    var tableViewCellVMs: [ShowAllCityTableViewCellVM] = []
    
    init(allCities: [Country]) {
        self.allCities = allCities
//        self.tableViewCellVMs = allCities.map { ShowAllCityTableViewCellVM(city: $0) }
    }
}

extension AllCityView {
    func setView(viewModel: AllCityVM) {
        self.viewModel = viewModel
        showAllCity.reloadData()
    }
}

class AllCityView: UIView {
    
    @IBOutlet weak var showAllCity: UITableView!
    
    static let identifier = "\(AllCityView.self)"
    
    private var viewModel: AllCityVM?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AllCityView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.allCities.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.allCities[section].isExpanded ? viewModel.allCities[section].cityList.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShowAllCityTableViewCell.identifier) as? ShowAllCityTableViewCell else { fatalError()}
        
        return cell
    }
}

extension AllCityView {
    
    private func customInit() {
        let nib = UINib(nibName: String(describing: AllCityView.identifier), bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("\(self)載入失敗")
        }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        
        setupUI()
    }
    
    private func setupUI() {
        showAllCity.delegate = self
        showAllCity.dataSource = self
        showAllCity.register(UINib(nibName: ShowAllCityTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ShowAllCityTableViewCell.identifier)
    }
}
