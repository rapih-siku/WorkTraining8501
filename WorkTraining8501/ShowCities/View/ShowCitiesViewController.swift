//
//  ShowCitiesViewController.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/25.
//

import UIKit

class ShowCitiesViewController: UIViewController {
    
    @IBOutlet weak var popCity: UIButton!
    @IBOutlet weak var allCity: UIButton!
    @IBOutlet weak var pages: UIStackView!
    @IBOutlet weak var pageScroll: UIScrollView!
    @IBOutlet weak var scrollLineLeading: NSLayoutConstraint!
    
    let selectedColor = UIColor(red: 170/255, green: 96/255, blue: 200/255, alpha: 1)
    let unselectedColor = UIColor.lightGray
    
    private var viewModel: ShowCitiesViewModel?
    private var popCityPage: PopCityView?
    private var allCityPage: AllCityView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupPages()
        bindViewModel()
    }
    
    @IBAction func toPopCity(_ sender: Any) {
        pageScroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        setupScrollLineLeading()
    }
    
    @IBAction func toAllCity(_ sender: Any) {
        pageScroll.setContentOffset(CGPoint(x: self.pageScroll.frame.width, y: 0), animated: true)
        setupScrollLineLeading()
    }
}

extension ShowCitiesViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        
        UIView.animate(withDuration: 0.2) {
            self.scrollLineLeading.constant = offset.x / 2
            self.view.layoutIfNeeded()
        }
        
        let isFirstPage = offset.x < scrollView.frame.width / 2
        popCity.setTitleColor(isFirstPage ? selectedColor : unselectedColor, for: .normal)
        allCity.setTitleColor(isFirstPage ? unselectedColor : selectedColor, for: .normal)
    }
}

extension ShowCitiesViewController {
    
    private func bindViewModel() {
        viewModel = ShowCitiesViewModel()

        viewModel?.fetchPopCityData(completion: { [weak self] popCites in
            let vm = PopCityViewModel(popCityData: popCites.moduleItemList)
            
            vm.didTapButton = {
                self?.pageScroll.setContentOffset(CGPoint(x: CGFloat(self?.pageScroll.frame.width ?? 0), y: 0), animated: true)
                self?.setupScrollLineLeading()
            }
            
            DispatchQueue.main.async {
                self?.popCityPage?.setView(viewModel: vm)
            }
        })
        
        viewModel?.fetchAllCityData(completion: { [weak self] allCity in
            let vm = AllCityViewModel(allCities: allCity.countryList)
            DispatchQueue.main.async {
                self?.allCityPage?.setView(viewModel: vm)
            }
        })
    }
    
    private func setupPages() {
        let page1 = PopCityView()
        let page2 = AllCityView()
        let pageViews: [UIView] = [page1, page2]
        let scrollWidth = pageScroll.frame.width
        let scrollHeight = pageScroll.frame.height
        
        pageViews.forEach { page in
            page.frame = CGRect(x: 0, y: 0, width: scrollWidth, height: scrollHeight)
            page.translatesAutoresizingMaskIntoConstraints = false
            pages.addArrangedSubview(page)
            
            page.widthAnchor.constraint(equalTo: pageScroll.frameLayoutGuide.widthAnchor).isActive = true
            page.heightAnchor.constraint(equalTo: pageScroll.frameLayoutGuide.heightAnchor).isActive = true
        }
        
        pages.widthAnchor.constraint(equalTo: pageScroll.frameLayoutGuide.widthAnchor, multiplier: 2).isActive = true
        self.popCityPage = page1
        self.allCityPage = page2
    }
    
    private func setupUI() {
        pageScroll.delegate = self
        
        popCity.setTitle("熱門城市", for: .normal)
        popCity.setTitleColor(selectedColor, for: .normal)
        allCity.setTitle("全部目的地", for: .normal)
        allCity.setTitleColor(unselectedColor, for: .normal)
        
        let searchBar = UISearchBar()
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.placeholder = "搜尋國家／城市／票卷"
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(toCart))
    }
    
    @objc private func toCart() {
        print("前往購物車")
    }
    
    private func setupScrollLineLeading() {
        UIView.animate(withDuration: 0.2) {
            self.scrollLineLeading.constant = self.pageScroll.contentOffset.x / 2
            self.view.layoutIfNeeded()
        }
    }
}
