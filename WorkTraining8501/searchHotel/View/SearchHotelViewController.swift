//
//  searchHotelViewController.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/31.
//

import UIKit

class SearchHotelViewController: UIViewController {
    
    @IBOutlet weak var showHotel: UITableView!
    @IBOutlet weak var filterData: UIButton!
    @IBOutlet weak var sortData: UIButton!
    @IBOutlet weak var sortOptionHeight: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var priceLowToHigh: UIButton!
    @IBOutlet weak var priceHighToLow: UIButton!
    
    private var viewModel: SearchHotelViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        setupUI()
    }
    
    @IBAction func showSortDataView(_ sender: Any) {
        toggleSortDataView(isHidden: !(viewModel?.sortOptionIsHidden ?? true))
        viewModel?.sortOptionIsHidden.toggle()
    }
    
    @IBAction func sortData(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            viewModel?.isPriceDescending = false
        case 1:
            viewModel?.isPriceDescending = true
        default:
            break
        }
        
        viewModel?.sortData {
            self.updateUI()
            
            self.priceHighToLow.tintColor = self.viewModel?.isPriceDescending ?? false ? .purple : .black
            self.priceLowToHigh.tintColor = self.viewModel?.isPriceDescending ?? false ? .black : .purple
            
            self.toggleSortDataView(isHidden: true)
            self.viewModel?.sortOptionIsHidden = true
        }
    }
    
    @IBAction func showSearchFilter(_ sender: Any) {
        self.toggleSortDataView(isHidden: true)
        self.viewModel?.sortOptionIsHidden = true
        
        let bottomSheetVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FiltersBottomSheetViewController") as! FiltersBottomSheetViewController
        if let sheetPresentationController = bottomSheetVC.sheetPresentationController {
            sheetPresentationController.detents = [ .custom(resolver: { context in
                return bottomSheetVC.getBottomSheetHeight()
            })]
        }
        let vm = FiltersBottomSheetViewModel(
            minPrice: viewModel?.minPrice ?? 0,
            maxPrice: viewModel?.maxPrice ?? 0,
            leftThumbConstant: viewModel?.leftThumbConstant ?? 0,
            rightThumbConstant: viewModel?.rightThumbConstant ?? 0
        )
        
        vm.tapFilter = { [weak self] minPrice, maxPrice in
            let filteredHotels = self?.viewModel?.originalHotelsData.filter({ hotel in
                (minPrice...maxPrice).contains(hotel.retailPriceValue)
            })
            self?.viewModel?.hotels = filteredHotels ?? []
            self?.viewModel?.sortData {
                self?.updateUI()
            }
        }
        
        vm.setThumbPosition = { [weak self] leftThumbPosition, rightThumbPosition in
            self?.viewModel?.leftThumbConstant = leftThumbPosition
            self?.viewModel?.rightThumbConstant = rightThumbPosition
        }
        
        bottomSheetVC.setVC(viewModel: vm)
        present(bottomSheetVC, animated: true)
    }
}

extension SearchHotelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.hotels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShowHotelTableViewCell.identifier, for: indexPath) as? ShowHotelTableViewCell else { fatalError() }
        cell.selectionStyle = .none
        let vm = viewModel?.showHotelTableViewVMs[indexPath.row]
        cell.setCell(viewModel: vm)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("點擊了\(viewModel?.hotels[indexPath.row].hotelName ?? "")")
    }
}

extension SearchHotelViewController {
    private func bindViewModel() {
        viewModel = SearchHotelViewModel()
    }
    
    private func setupUI() {
        showHotel.dataSource = self
        showHotel.delegate = self
        
        let showHotelTableViewCell = UINib(nibName: ShowHotelTableViewCell.identifier, bundle: nil)
        showHotel.register(showHotelTableViewCell, forCellReuseIdentifier: ShowHotelTableViewCell.identifier)
        showHotel.tableHeaderView = createHeaderView()
        
        setupMainButton(button: sortData, imageSystemName: "arrow.up.arrow.down", title: "排序")
        setupMainButton(button: filterData, imageSystemName: "slider.horizontal.3", title: "篩選")
        
        toggleSortDataView(isHidden: true)
    }
    
    private func setupMainButton(button: UIButton, imageSystemName: String, title: String) {
        let purpleColor = UIColor(red: 170/255, green: 96/255, blue: 200/255, alpha: 1)
        let buttonImage = UIImage(systemName: imageSystemName)?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 15))
            .withRenderingMode(.alwaysTemplate)
        let buttonTitle = NSAttributedString(
            string: title,
            attributes: [
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 15)
            ])
        button.setImage(buttonImage, for: .normal)
        button.tintColor = purpleColor
        button.setAttributedTitle(buttonTitle, for: .normal)
    }
    
    private func updateUI() {
        showHotel.reloadData()
        showHotel.tableHeaderView = createHeaderView()
        if showHotel.contentOffset.y != 0 {
            DispatchQueue.main.async {
                self.showHotel.setContentOffset(.zero, animated: true)
            }
        }
    }
    
    private func toggleSortDataView(isHidden: Bool) {
        if isHidden == false {
            self.sortOptionHeight.constant = 85
            self.stackView.isHidden = false
            self.backgroundView.isHidden = false
        } else {
            self.sortOptionHeight.constant = 0
            self.stackView.isHidden = true
            self.backgroundView.isHidden = true
        }
    }
    
    private func createHeaderView() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        headerView.frame = CGRect(x: 0, y: 0, width: showHotel.frame.width, height: 40)
        
        let label = UILabel()
        let count = viewModel?.hotels.count ?? 0
        
        let prefixText = NSAttributedString(
            string: "共(",
            attributes: [
                .foregroundColor: UIColor.gray,
                .font: UIFont.systemFont(ofSize: 15)
            ]
        )
        let countText = NSAttributedString(
            string: "\(count)",
            attributes: [
                .foregroundColor: UIColor(red: 170/255, green: 96/255, blue: 200/255, alpha: 1),
                .font: UIFont.boldSystemFont(ofSize: 15)
            ])
        let suffixText = NSAttributedString(
            string: ")筆結果",
            attributes: [
                .foregroundColor: UIColor.gray,
                .font: UIFont.systemFont(ofSize: 15)
            ]
        )
        let text = NSMutableAttributedString(attributedString: prefixText)
        text.append(countText)
        text.append(suffixText)
        
        label.attributedText = text
        label.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10)
        ])
        
        return headerView
    }
}
