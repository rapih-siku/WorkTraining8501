//
//  searchHotelViewController.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/31.
//

import UIKit

class SearchHotelViewModel {
    var hotels: [Hotel] = []
    var showHotelTableViewVMs: [ShowHotelTableViewCellViewModel] = []
    
    init() {
        fetchHotelsData {
            self.showHotelTableViewVMs = self.hotels.map { ShowHotelTableViewCellViewModel(hotel: $0) }
        }
    }
    
    func fetchHotelsData(completion: (() -> Void)? = nil) {
        guard let url = Bundle.main.url(forResource: "HotelList", withExtension: "json") else { fatalError("🔴找不到資料") }
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(HotelsData.self, from: data)
            hotels = response.hotelList.sorted { $0.retailPriceValue < $1.retailPriceValue }
            completion?()
        } catch {
            print("🔴資料解析失敗：\(error.localizedDescription)")
        }
    }
}

class SearchHotelViewController: UIViewController {
    
    @IBOutlet weak var showHotel: UITableView!
    @IBOutlet weak var filterData: UIButton!
    @IBOutlet weak var sortData: UIButton!
    @IBOutlet weak var sortOptionHeight: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var backgroundView: UIView!
    
    var sortOptionIsHidden = true
    
    private var viewModel: SearchHotelViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupUI()
    }
    
    @IBAction func sortHotels(_ sender: Any) {
        
        if sortOptionIsHidden == true {
            self.sortOptionHeight.constant = 85
            self.stackView.isHidden = false
            self.backgroundView.isHidden = false
        } else {
            self.sortOptionHeight.constant = 0
            self.stackView.isHidden = true
            self.backgroundView.isHidden = true
        }
        sortOptionIsHidden.toggle()
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
        
        setupButton(button: sortData, systemName: "arrow.up.arrow.down", title: "排序")
        setupButton(button: filterData, systemName: "slider.horizontal.3", title: "篩選")
        
        self.sortOptionHeight.constant = 0
        self.stackView.isHidden = true
    }
    
    private func setupButton(button: UIButton, systemName: String, title: String) {
        let purpleColor = UIColor(red: 170/255, green: 96/255, blue: 200/255, alpha: 1)
        let sortingImage = UIImage(systemName: systemName)?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 15))
            .withRenderingMode(.alwaysTemplate)
        let buttonTitle = NSAttributedString(
            string: title,
            attributes: [
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 15)
            ])
        button.setImage(sortingImage, for: .normal)
        button.tintColor = purpleColor
        button.setAttributedTitle(buttonTitle, for: .normal)
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
