//
//  ShowADViewController.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/21.
//

import UIKit

class ShowAdViewController: UIViewController {
    
    @IBOutlet weak var adCategories: UITableView!
    
    private var viewModel: ShowAdVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adCategories.dataSource = self
        adCategories.delegate = self
        
        bindViewModel()
    }
}

extension ShowAdViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.adModules.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AdCategoryTableViewCell.identifier, for: indexPath) as? AdCategoryTableViewCell else { fatalError() }
        cell.selectionStyle = .none
        
        let vm = viewModel?.cellVMs[indexPath.row]
        cell.setCell(viewModel: vm)
        
        return cell
    }
}

extension ShowAdViewController {
    private func bindViewModel() {
        viewModel = ShowAdVM()
    }
}
