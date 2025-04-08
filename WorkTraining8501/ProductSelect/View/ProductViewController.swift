//
//  OrderViewController.swift
//  Colatour
//
//  Created by Labe on 2025/3/7.
//

import UIKit

extension ProductViewController {
    func setVC(viewModel: ProductViewModel) {
        self.viewModel = viewModel
    }
}

class ProductViewController: UIViewController {
    
    @IBOutlet weak var productCustomization: UIButton!
    
    private var viewModel: ProductViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem?.title = "登出"
        navigationItem.backButtonTitle = ""
        
        productCustomization.configuration?.title = viewModel?.productCustomizationTitle()
    }
    
    @IBAction func selectCustomerType(_ sender: Any) {
        let productBottomSheetVC = storyboard?.instantiateViewController(withIdentifier: "ProductBottomSheetViewController") as! ProductBottomSheetViewController
        
        if let sheetPresentationController = productBottomSheetVC.sheetPresentationController {
            sheetPresentationController.detents = [.custom(resolver: { context in
                return productBottomSheetVC.getVCTotalHeight()
            })]
        }
        
        let vm = ProductBottomSheetViewModel(list: viewModel?.currentTravelersInfos ?? [])
        vm.sentNewTravelersInfo = { [weak self] newTravelersInfo in
            self?.viewModel?.currentTravelersInfos = newTravelersInfo
            let title = self?.viewModel?.productCustomizationTitle()
            self?.productCustomization.configuration?.title = title
        }
        productBottomSheetVC.setVC(viewModel: vm)
        
        present(productBottomSheetVC, animated: true)
    }
    
    @IBAction func toChatRoom(_ sender: Any) {
        let chatRoomVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatRoomViewController") as! ChatRoomViewController
        let vm = ChatRoomViewModel()
        vm.chatContent = vm.loadMessagesData()
        chatRoomVC.setVC(viewModel: vm)
        self.navigationController?.pushViewController(chatRoomVC, animated: true)
    }
    

    @IBAction func toShowCity(_ sender: Any) {
        let showCitiesVC = self.storyboard?.instantiateViewController(withIdentifier: "ShowCitiesViewController") as! ShowCitiesViewController
        navigationController?.pushViewController(showCitiesVC, animated: true)
        
    }

    @IBAction func toBooking(_ sender: Any) {
        let showAdVC = storyboard?.instantiateViewController(withIdentifier: "ShowAdViewController") as! ShowAdViewController
        showAdVC.navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(showAdVC, animated: true)
    }
    
    @IBAction func toSearchHotel(_ sender: Any) {
        let searchHotelVC = storyboard?.instantiateViewController(withIdentifier: "SearchHotelViewController") as! SearchHotelViewController
        searchHotelVC.navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(searchHotelVC, animated: true)
    }
}
