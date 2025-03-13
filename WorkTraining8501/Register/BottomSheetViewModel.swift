//
//  BottomSheetViewModel.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/12.
//

import Foundation

class BottomSheetViewModel {
    let educationData = ["博士", "碩士", "學士"]
    var selectedEducation: String?
    
    var sentSelectedEducation: ((String) -> Void)?
    
    func isSelected(education: String) -> Bool {
        print(selectedEducation)
        return education == selectedEducation
    }
    
    func selectEducation(education: String) {
        selectedEducation = education
        sentSelectedEducation?(education)
    }
    
    func setEducation(education: String?) {
        selectedEducation = education
    }
}
