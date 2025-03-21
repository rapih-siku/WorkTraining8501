//
//  SelectionTableViewCellVM.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/17.
//

import Foundation
import UIKit

class SelectionTableViewCellVM {
    var travelerInfo: TravelersInfo?
    var title: String {
        return "\(travelerInfo?.travelerType ?? "") \(travelerInfo?.age ?? "")"
    }
    var count: String {
        return "\(travelerInfo?.count ?? 0)"
    }
    
    var onDataUpdated: (() -> Void)?
    
    init(travelersInfo: TravelersInfo? = nil) {
        self.travelerInfo = travelersInfo
    }
    
    func increaseCount() {
        travelerInfo?.count += 1
        onDataUpdated?()
    }
    
    func decreaseCount() {
        travelerInfo?.count -= 1
        onDataUpdated?()
    }
    
    func adjustButton(button: UIButton) {
        if travelerInfo?.travelerType == "大人" && (travelerInfo?.count ?? 0) <= 1 {
            button.isEnabled = false
            button.tintColor = .gray
        } else if
            (travelerInfo?.count ?? 0) <= 0 {
            button.isEnabled = false
            button.tintColor = .gray
        } else {
            button.isEnabled = true
            button.tintColor = UIColor(red: 170/255, green: 96/255, blue: 200/255, alpha: 1)
        }
    }
}
