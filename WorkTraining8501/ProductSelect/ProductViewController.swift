//
//  OrderViewController.swift
//  Colatour
//
//  Created by Labe on 2025/3/7.
//

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet weak var productCustomization: UIButton!
    
    var travelersInfos = [TravelersInfo(travelerType: "大人",age: "(12+)", count: 1), TravelersInfo(travelerType: "小孩", age: "(2-11)", count: 0), TravelersInfo(travelerType: "嬰兒",age: "(<2)", count: 0)]
    var productCustomizationTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem?.title = "登出"
        showProductCustomizationTitle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProductCustomization" {
            
            if let destination = segue.destination as? ProductCustomizationViewController {
                destination.loadViewIfNeeded()
                if let sheetPresentationController = destination.sheetPresentationController {
                    sheetPresentationController.detents = [
                        .custom(resolver: { context in
                            return destination.getVCTotalHeight()
                        })
                    ]
                }
                
                destination.currentTravelersInfos = travelersInfos
                
                destination.sentTravelersInfos = { [weak self] travelersInfos in
                    self?.travelersInfos = travelersInfos
                    self?.showProductCustomizationTitle()
                }
            }
        }
    }
    
    func showProductCustomizationTitle() {
        //        productCustomizationTitle = "旅遊人數\n\(customerTypeSelection[0].count)\(customerTypeSelection[0].travelerType) \(customerTypeSelection[1].count)\(customerTypeSelection[1].travelerType) \(customerTypeSelection[2].count)\(customerTypeSelection[2].travelerType)" 簡化↓
        productCustomizationTitle = travelersInfos
            .map { "\($0.count)\($0.travelerType)" }
            .joined(separator: " ")
        productCustomization.setTitle("旅遊人數\n" + productCustomizationTitle, for: .normal)
    }
    
    @IBAction func selectCustomerType(_ sender: Any) {
        performSegue(withIdentifier: "showProductCustomization", sender: nil)
    }
}
