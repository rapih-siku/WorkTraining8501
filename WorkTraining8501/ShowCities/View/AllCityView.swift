//
//  AllCityView.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/26.
//

import UIKit

extension AllCityView {
    func setView(viewModel: AllCityViewModel) {
        self.viewModel = viewModel
        showAllCity.reloadData()
    }
}

class AllCityView: UIView {
    
    @IBOutlet weak var showAllCity: UITableView!
    
    static let identifier = "\(AllCityView.self)"
    
    private var viewModel: AllCityViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
}

extension AllCityView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.countrySectionHeaderVMs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.countrySectionHeaderVMs[section].countryIsExpanded ? viewModel.countrySectionHeaderVMs[section].showAllCityTableViewCellVMs.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShowAllCityTableViewCell.identifier) as? ShowAllCityTableViewCell else { fatalError()}
        let vm = viewModel?.countrySectionHeaderVMs[indexPath.section].showAllCityTableViewCellVMs[indexPath.row]
        cell.selectionStyle = .none
        cell.setCell(viewModel: vm)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = CountrySectionHeaderView()
        guard let vm = viewModel?.countrySectionHeaderVMs[section] else { return UITableViewCell() }
        header.setView(viewModel: vm)
        header.setSectionHeaderView()
        vm.onTap = { [weak self] in
            vm.countryIsExpanded.toggle()
            self?.showAllCity.reloadSections([section], with: .automatic)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tapCityName = viewModel?.countrySectionHeaderVMs[indexPath.section].showAllCityTableViewCellVMs[indexPath.row].cityName
        print("點擊了\(tapCityName ?? "")")
    }
}

extension AllCityView {
    
    private func customInit() {
        let nib = UINib(nibName: String(describing: AllCityView.identifier), bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError("\(self)載入失敗") }
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
