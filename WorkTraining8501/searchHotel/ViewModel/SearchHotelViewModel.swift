//
//  SearchHotelViewModel.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/4/7.
//

import Foundation

class SearchHotelViewModel {
    
    var originalHotelsData: [Hotel] = []
    var hotels: [Hotel] = []
    var showHotelTableViewVMs: [ShowHotelTableViewCellViewModel] = []
    var isPriceDescending: Bool = false
    var sortOptionIsHidden = true
    var maxPrice: Int?
    var minPrice: Int?
    var leftThumbConstant: Double?
    var rightThumbConstant: Double?
    
    init() {
        fetchHotelsData {
            self.createShowHotelTableViewVMs()
            self.filterMinAndMaxPrice()
        }
    }
    
    func fetchHotelsData(completion: (() -> Void)? = nil) {
        guard let url = Bundle.main.url(forResource: "HotelList", withExtension: "json") else { fatalError("🔴找不到資料") }
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(HotelsData.self, from: data)
            originalHotelsData = response.hotelList.sorted { $0.retailPriceValue < $1.retailPriceValue }
            hotels = originalHotelsData
            completion?()
        } catch {
            print("🔴資料解析失敗：\(error.localizedDescription)")
        }
    }
    
    func createShowHotelTableViewVMs() {
        self.showHotelTableViewVMs = self.hotels.map { ShowHotelTableViewCellViewModel(hotel: $0) }
    }
    
    func sortData(completion: @escaping () -> Void) {
        if isPriceDescending == false {
            hotels = hotels.sorted { $0.retailPriceValue < $1.retailPriceValue }
        } else {
            hotels = hotels.sorted { $0.retailPriceValue > $1.retailPriceValue }
        }
        createShowHotelTableViewVMs()
        completion()
    }
    
    func filterMinAndMaxPrice() {
        minPrice = hotels.min(by: { $0.retailPriceValue < $1.retailPriceValue })?.retailPriceValue
        maxPrice = hotels.max(by: { $0.retailPriceValue < $1.retailPriceValue })?.retailPriceValue
    }
}
