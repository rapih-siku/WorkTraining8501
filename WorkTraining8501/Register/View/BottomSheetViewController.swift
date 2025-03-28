//
//  BottomSheetViewController.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/10.
//

import UIKit

extension BottomSheetViewController {
    func setVC(viewModel: BottomSheetViewModel) {
        self.viewModel = viewModel
    }
}

class BottomSheetViewController: UIViewController {

    @IBOutlet weak var optionsTableView: UITableView!
    
    private var viewModel: BottomSheetViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        optionsTableView.dataSource = self
        optionsTableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        optionsTableView.reloadData()
        optionsTableView.layoutIfNeeded()
        
        self.preferredContentSize = CGSize(width: view.frame.width, height: getVCTotalHeigh())
    }
    
    func getVCTotalHeigh() -> CGFloat {
        let totalHeigh = CGFloat(optionsTableView.contentSize.height + 60)
        return totalHeigh
    }
}

extension BottomSheetViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.educationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BottomSheetTableViewCell.reuseIdentifier, for: indexPath) as? BottomSheetTableViewCell else { fatalError() }
        let currentEducation = viewModel.educationData[indexPath.row]
        cell.option.text = currentEducation
        cell.option.textColor = viewModel.isSelected(education: currentEducation) ? .purple : .black
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = viewModel.educationData[indexPath.row]
        viewModel.selectEducation(education: selected)
        dismiss(animated: true)
    }
}
