//
//  ShowCitiesViewController.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/25.
//

import UIKit

class ShowCitiesVM {
    
    func loadJSON<T: Codable>(fileName: String, type: T.Type, completion: ((T) -> Void)? = nil) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            fatalError("🔴找不到\(fileName)資料")
        }
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(T.self, from: data)
            completion?(response)
        } catch {
            print("🔴\(fileName)資料解析失敗")
        }
    }
    
    func fetchPopCityData(completion: ((PopCityData) -> Void)? = nil) {
        loadJSON(fileName: "PopCity", type: PopCityData.self) { response in
            completion?(response)
        }
    }
    
    func fetchAllCityData(completion: ((AllCityData) -> Void)? = nil) {
        loadJSON(fileName: "AllCity", type: AllCityData.self) { response in
            completion?(response)
        }
    }
}

class ShowCitiesViewController: UIViewController {

    @IBOutlet weak var pageScroll: UIScrollView!
    
    private var viewModel: ShowCitiesVM?
    private var popCityPage: PopCityView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPages()
        bindViewModel()
    }
}

extension ShowCitiesViewController {
    private func bindViewModel() {
        viewModel = ShowCitiesVM()
        
        viewModel?.fetchPopCityData(completion: { [weak self] popCites in
            let vm = PopCityVM(popCityData: popCites.moduleItemList)
            DispatchQueue.main.async {
                self?.popCityPage?.setView(viewModel: vm)
            }
        })
        
        //抓取全城市資料（設定頁面的VM）
    }
    
    private func setupPages() {
        let page = PopCityView()
        page.frame = CGRect(x: 0, y: 0, width: pageScroll.frame.width, height: pageScroll.frame.height)
        pageScroll.addSubview(page)
        self.popCityPage = page
        
        //增加頁數
    }
}
