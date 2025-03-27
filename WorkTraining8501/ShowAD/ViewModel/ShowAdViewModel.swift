//
//  adCategoryVM.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/21.
//

import Foundation

class ShowAdViewModel {
    
    var adModules: [Module] = []
    var cellVMs: [AdCategoryTableViewCellViewModel] = []
    
    init() {
        fetchAds(completion: {
            self.cellVMs = self.adModules.map({AdCategoryTableViewCellViewModel(adModule: $0)})
        })
    }
    
    func fetchAds(completion: (() -> Void)? = nil) {
        guard let url = Bundle.main.url(forResource: "ADTrain1", withExtension: "json") else {
            fatalError("🔴找不到資料")
        }
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(AdData.self, from: data)
            adModules = response.moduleLists
            completion?()
        } catch {
            print("🔴資料解析失敗：\(error.localizedDescription)")
        }
    }
}
