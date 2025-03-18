//
//  BottomSheetViewController.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/10.
//

import UIKit

class BottomSheetViewController: UIViewController {

    @IBOutlet weak var optionsTableView: UITableView!
    var viewModel: RegisterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BottomSheetViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.educationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BottomSheetTableViewCell.reuseIdentifier, for: indexPath) as? BottomSheetTableViewCell else { fatalError() }
        cell.option.text = viewModel.educationData[indexPath.row]
        return cell
    }
}
