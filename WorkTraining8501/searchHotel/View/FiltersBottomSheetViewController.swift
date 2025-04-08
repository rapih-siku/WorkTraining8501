//
//  FiltersBottomSheetViewController.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/4/1.
//

import UIKit

extension FiltersBottomSheetViewController {
    func setVC(viewModel: FiltersBottomSheetViewModel) {
        self.viewModel = viewModel
    }
}

class FiltersBottomSheetViewController: UIViewController {
    
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var leftThumb: UIView!
    @IBOutlet weak var rightThumb: UIView!
    @IBOutlet weak var priceRange: UIView!
    @IBOutlet weak var sliderRails: UIView!
    @IBOutlet weak var minPrice: UILabel!
    @IBOutlet weak var maxPrice: UILabel!
    @IBOutlet weak var filter: UIButton!
    @IBOutlet weak var leftThumbLeading: NSLayoutConstraint!
    @IBOutlet weak var rightThumbLeading: NSLayoutConstraint!
    
    private var viewModel: FiltersBottomSheetViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        updatePriceRange()
    }
    
    func getBottomSheetHeight() -> CGFloat {
        return filter.frame.maxY + 20
    }
    
    @IBAction func filter(_ sender: Any) {
        viewModel?.leftThumbConstant = leftThumbLeading.constant
        viewModel?.rightThumbConstant = rightThumbLeading.constant
        
        viewModel?.tapFilter?(viewModel?.sliderMinValue ?? 0, viewModel?.sliderMaxValue ?? 0)
        viewModel?.setThumbPosition?(viewModel?.leftThumbConstant ?? 0, viewModel?.rightThumbConstant ?? 0)
        dismiss(animated: true)
    }
    
    @IBAction func cleanSearchFilter(_ sender: Any) {
        leftThumbLeading.constant = 0
        rightThumbLeading.constant = sliderRails.frame.width - rightThumb.frame.width
        
        updatePriceRange()
    }
}

extension FiltersBottomSheetViewController {
    
    private func setupUI() {
        
        [leftThumb, rightThumb].forEach {
            $0?.backgroundColor = .white
            $0?.frame.size.width = 20
            $0?.frame.size.height = 20
            $0?.layer.cornerRadius = ($0?.frame.width ?? 0) / 2
            $0?.clipsToBounds = true
            $0?.layer.shadowColor = UIColor.black.cgColor
            $0?.layer.shadowOffset = .zero
            $0?.layer.shadowRadius = 4
            $0?.layer.shadowOpacity = 0.2
            $0?.layer.masksToBounds = false
        }
        
        let panLeft = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        let panRight = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        leftThumb.addGestureRecognizer(panLeft)
        rightThumb.addGestureRecognizer(panRight)
        
        minPrice.text = "$\(formattedPrice(price: viewModel?.sliderMinValue ?? 0))"
        maxPrice.text = "$\(formattedPrice(price: viewModel?.sliderMaxValue ?? 0))"
        
        leftThumbLeading.constant = viewModel?.leftThumbConstant ?? 0
        if let position = viewModel?.rightThumbConstant, position > 0 {
            rightThumbLeading.constant = position
        } else {
            sliderView.layoutIfNeeded()
            rightThumbLeading.constant = sliderRails.frame.width - rightThumb.frame.width
        }
        
        updatePriceRange()
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let thumb = gesture.view else { return }
        
        let translation = gesture.translation(in: sliderRails)
        gesture.setTranslation(.zero, in: sliderRails)
        let thumbWidth = thumb.frame.width
        let maxRailX = sliderRails.frame.width
        
        if thumb == leftThumb {
            var newConstant = leftThumbLeading.constant + translation.x
            let maxRight = rightThumbLeading.constant - thumbWidth
            newConstant = max(0, min(maxRight, newConstant))
            leftThumbLeading.constant = newConstant
        } else {
            var newConstant = rightThumbLeading.constant + translation.x
            let minLeft = leftThumbLeading.constant + thumbWidth
            let maxRailX = maxRailX - thumbWidth
            newConstant = max(minLeft, min(maxRailX, newConstant))
            rightThumbLeading.constant = newConstant
        }
        
        sliderView.layoutIfNeeded()
        updatePriceRange()
    }
    
    private func updatePriceRange() {
        let leftX = leftThumbLeading.constant + leftThumb.frame.width
        let rightX = rightThumbLeading.constant
        let y = priceRange.frame.origin.y
        let height = sliderRails.frame.height
        
        priceRange.frame = CGRect(x: leftX, y: y, width: rightX - leftX, height: height)
        
        viewModel?.sliderMinValue = valueFromSlider(x: leftX)
        viewModel?.sliderMaxValue = valueFromSlider(x: rightX)
        
        minPrice.text = "$\(formattedPrice(price: viewModel?.sliderMinValue ?? 0))"
        maxPrice.text = "$\(formattedPrice(price: viewModel?.sliderMaxValue ?? 0))"
    }
    
    private func valueFromSlider(x: CGFloat) -> Int {
        let priceMin = viewModel?.minPrice ?? 0
        let priceMax = viewModel?.maxPrice ?? 0
        let totalRange = sliderRails.frame.width - leftThumb.frame.width * 2
        let adjustedX = max(0, min(x - leftThumb.frame.width, totalRange))
        let ratio = adjustedX / totalRange
        return Int(priceMin + (priceMax - priceMin) * ratio)
    }
    
    private func formattedPrice(price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: price)) ?? ""
    }
}
