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
    
    @IBOutlet weak var leftThumb: UIView!
    @IBOutlet weak var rightThumb: UIView!
    @IBOutlet weak var priceRange: UIView!
    @IBOutlet weak var sliderRails: UIView!
    @IBOutlet weak var minPrice: UILabel!
    @IBOutlet weak var maxPrice: UILabel!
    @IBOutlet weak var filter: UIButton!
    
    private var viewModel: FiltersBottomSheetViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func getBottomSheetHeight() -> CGFloat {
        return filter.frame.maxY
    }
    
    @IBAction func filter(_ sender: Any) {
        viewModel?.leftThumbPosition = leftThumb.frame.origin.x
        viewModel?.rightThumbPosition = rightThumb.frame.origin.x
        
        viewModel?.tapFilter?(viewModel?.sliderMinValue ?? 0, viewModel?.sliderMaxValue ?? 0)
        viewModel?.setThumbPosition?(viewModel?.leftThumbPosition ?? 0, viewModel?.rightThumbPosition ?? 0)
        dismiss(animated: true)
    }
    
    @IBAction func cleanSearchFilter(_ sender: Any) {
        leftThumb.frame.origin.x = 0
        rightThumb.frame.origin.x = sliderRails.frame.width
        
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
        
        leftThumb.frame.origin.x = viewModel?.leftThumbPosition ?? 0
        if let position = viewModel?.rightThumbPosition, position > 0 {
            rightThumb.frame.origin.x = position
        } else {
            rightThumb.frame.origin.x = sliderRails.frame.width
        }
        
        updatePriceRange()
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let thumb = gesture.view else { return }
        
        let translation = gesture.translation(in: sliderRails)
        var newX = thumb.frame.origin.x + translation.x
        let thumbWidth = thumb.frame.width
        let maxRailX = sliderRails.frame.width
        
        if thumb == leftThumb {
            let maxRight = rightThumb.frame.minX - thumbWidth
            newX = max(0, min(maxRight, newX))
        } else {
            let minLeft = leftThumb.frame.maxX
            let maxRight = maxRailX
            newX = max(minLeft, min(maxRight, newX))
        }
        
        thumb.frame.origin.x = newX
        gesture.setTranslation(.zero, in: sliderRails)
        
        updatePriceRange()
    }
    
    private func updatePriceRange() {
        let leftX = leftThumb.frame.maxX
        let rightX = rightThumb.frame.minX
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
        let totalRange = sliderRails.frame.width - leftThumb.frame.width
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
