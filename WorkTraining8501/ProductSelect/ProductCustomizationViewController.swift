//
//  ProductCustomizationViewController.swift
//  Colatour
//
//  Created by Labe on 2025/3/7.
//

import UIKit

class ProductCustomizationViewController: UIViewController {

    @IBOutlet weak var selectionTableView: UITableView!
    
    var currentTravelersInfos: [TravelersInfo] = []
    var sentTravelersInfos: (([TravelersInfo]) -> Void)?
    
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
        let totalHieght = CGFloat(selectionTableView.contentSize.height + 35 + 60)
        return totalHieght
    }
    
    @IBAction func confirm(_ sender: Any) {
        sentTravelersInfos?(currentTravelersInfos)
        self.dismiss(animated: true)
    }
}

extension ProductCustomizationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTravelersInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCustomizationTableViewCell.reuseIdentifier, for: indexPath) as? ProductCustomizationTableViewCell else { fatalError() }
        cell.selectionStyle = .none
        cell.title.text = currentTravelersInfos[indexPath.row].travelerType + currentTravelersInfos[indexPath.row].age
        cell.count.text = "\(currentTravelersInfos[indexPath.row].count)"
        cell.adjustButtonColor()
        
        cell.index = indexPath.row
        cell.countChanged = { [weak self] index, newCount in
            if index == 0 && newCount <= 1 {
                self?.currentTravelersInfos[index].count = 1
            } else {
                self?.currentTravelersInfos[index].count = newCount
            }
        }
        
        return cell
    }
}
