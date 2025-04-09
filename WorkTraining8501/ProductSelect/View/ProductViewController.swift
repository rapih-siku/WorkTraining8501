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
    @IBOutlet weak var chatRoom: UIButton!
    @IBOutlet weak var showAD: UIButton!
    @IBOutlet weak var showCities: UIButton!
    @IBOutlet weak var searchHotel: UIButton!
    
    static let identifier: String = "\(ProductViewController.self)"
    
    private var viewModel: ProductViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    @IBAction func selectCustomerType(_ sender: Any) {
        let productBottomSheetVC = ProductBottomSheetViewController(nibName: ProductBottomSheetViewController.identifier, bundle: nil)
        
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
        let chatRoomVC = ChatRoomViewController(nibName: ChatRoomViewController.identifier, bundle: nil)
        let vm = ChatRoomViewModel()
        vm.chatContent = vm.loadMessagesData()
        chatRoomVC.setVC(viewModel: vm)
        chatRoomVC.navigationItem.title = "聊天室"
        self.navigationController?.pushViewController(chatRoomVC, animated: true)
    }
    
    @IBAction func toShowAD(_ sender: Any) {
        let showAdVC = ShowAdViewController(nibName: ShowAdViewController.identifier, bundle: nil)
        showAdVC.navigationItem.title = "行程廣告"
        navigationController?.pushViewController(showAdVC, animated: true)
    }
    

    @IBAction func toShowCity(_ sender: Any) {
        let showCitiesVC = ShowCitiesViewController(nibName: ShowCitiesViewController.identifier, bundle: nil)
        navigationController?.pushViewController(showCitiesVC, animated: true)
        
    }
    
    @IBAction func toSearchHotel(_ sender: Any) {
        let searchHotelVC = SearchHotelViewController(nibName: SearchHotelViewController.identifier, bundle: nil)
        searchHotelVC.navigationItem.title = "搜尋飯店"
        navigationController?.pushViewController(searchHotelVC, animated: true)
    }
}

extension ProductViewController {
    
    private func setupUI() {
        navigationItem.backButtonTitle = ""
        
        productCustomization.configuration?.title = viewModel?.productCustomizationTitle()
        
        let buttons = [productCustomization, chatRoom, showAD, showCities, searchHotel]
        let purpleColor = CGColor(red: 170/255, green: 96/255, blue: 200/255, alpha: 1)
        buttons.forEach { button in
            button?.layer.borderWidth = 1
            button?.layer.borderColor = purpleColor
            button?.layer.cornerRadius = 5
            button?.tintColor = UIColor(cgColor: purpleColor)
            button?.backgroundColor = .clear
        }
    }
}
