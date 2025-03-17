//
//  OrderViewController.swift
//  Colatour
//
//  Created by Labe on 2025/3/7.
//

import UIKit

extension ProductViewController {
    func setVC(viewModel: ProductVM) {
        self.viewModel = viewModel
    }
}

class ProductViewController: UIViewController {
    
    @IBOutlet weak var productCustomization: UIButton!
    
    private var viewModel: ProductVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem?.title = "登出"
        
        productCustomization.configuration?.title = viewModel?.productCustomizationTitle()
    }
    
    @IBAction func selectCustomerType(_ sender: Any) {
        let ProductBottomSheetVC = storyboard?.instantiateViewController(withIdentifier: "ProductBottomSheetViewController") as! ProductBottomSheetViewController
        if let sheetPresentationController = ProductBottomSheetVC.sheetPresentationController {
            sheetPresentationController.detents = [.custom(resolver: { context in
                return ProductBottomSheetVC.getVCTotalHeight()
            })]
        }
        
        let vm = ProductBottomSheetVM(list: viewModel?.currentTravelersInfos ?? [])
        vm.sentNewTravelersInfo = { [weak self] newTravelersInfo in
            self?.viewModel?.currentTravelersInfos = newTravelersInfo
            let title = self?.viewModel?.productCustomizationTitle()
            self?.productCustomization.configuration?.title = title
        }
        ProductBottomSheetVC.setVC(viewModel: vm)
        
        present(ProductBottomSheetVC, animated: true)
    }
}
