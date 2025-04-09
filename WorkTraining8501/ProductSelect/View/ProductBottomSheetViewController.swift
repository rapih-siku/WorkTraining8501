//
//  ProductCustomizationViewController.swift
//  Colatour
//
//  Created by Labe on 2025/3/7.
//

import UIKit

extension ProductBottomSheetViewController {
    func setVC(viewModel:ProductBottomSheetViewModel) {
        self.viewModel = viewModel
    }
}

class ProductBottomSheetViewController: UIViewController {

    @IBOutlet weak var selectionTableView: UITableView!
    
    static let identifier: String = "\(ProductBottomSheetViewController.self)"
    
    private var viewModel: ProductBottomSheetViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        selectionTableView.reloadData()
        selectionTableView.layoutIfNeeded()
        
        self.preferredContentSize = CGSize(width: view.frame.width, height: getVCTotalHeight())
    }
    
    func getVCTotalHeight() -> CGFloat {
        let totalHeight = CGFloat(selectionTableView.contentSize.height + 35 + 60)
        return totalHeight
    }
    
    @IBAction func confirm(_ sender: Any) {
        viewModel?.confirmSelection()
        self.dismiss(animated: true)
    }
}

extension ProductBottomSheetViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellVMs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectionTableViewCell.identifier, for: indexPath) as? SelectionTableViewCell else { fatalError() }
        guard let vm = viewModel?.cellVMs[indexPath.row] else { return UITableViewCell() }
        
        vm.onDataUpdated = {
            self.selectionTableView.reloadRows(at: [indexPath], with: .automatic)
        }
        cell.selectionStyle = .none
        cell.setCell(viewModel: vm)
        
        return cell
    }
}

extension ProductBottomSheetViewController {
    
    private func setupUI() {
        selectionTableView.delegate = self
        selectionTableView.dataSource = self
        
        let selectionTableViewCell = UINib(nibName: SelectionTableViewCell.identifier, bundle: nil)
        selectionTableView.register(selectionTableViewCell, forCellReuseIdentifier: SelectionTableViewCell.identifier)
    }
}
