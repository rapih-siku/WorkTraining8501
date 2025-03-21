//
//  ProductCustomizationViewController.swift
//  Colatour
//
//  Created by Labe on 2025/3/7.
//

import UIKit

extension ProductBottomSheetViewController {
    func setVC(viewModel:ProductBottomSheetVM) {
        self.viewModel = viewModel
    }
}

class ProductBottomSheetViewController: UIViewController {

    @IBOutlet weak var selectionTableView: UITableView!
    
    private var viewModel: ProductBottomSheetVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectionTableView.delegate = self
        selectionTableView.dataSource = self
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: selectionTableViewCell.reuseIdentifier, for: indexPath) as? selectionTableViewCell else { fatalError() }
        cell.selectionStyle = .none
        
        guard let vm = viewModel?.cellVMs[indexPath.row] else { return UITableViewCell() }
        vm.onDataUpdated = {
            self.selectionTableView.reloadRows(at: [indexPath], with: .automatic)
        }
        cell.setCell(viewModel: vm)
        
        return cell
    }
}
