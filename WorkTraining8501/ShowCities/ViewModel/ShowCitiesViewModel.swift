//
//  ShowCitiesViewModel.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/28.
//

import Foundation

class ShowCitiesViewModel {
    var currentPage = 0
    
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
