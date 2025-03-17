//
//  RegisterViewController.swift
//  Colatour
//
//  Created by Labe on 2025/3/5.
//

import UIKit

extension RegisterViewController {
    func setVC(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
    }
}

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var male: UIButton!
    @IBOutlet weak var female: UIButton!
    @IBOutlet weak var education: UIButton!
    @IBOutlet weak var agreeRule: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var register: UIButton!
    
    private var viewModel: RegisterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    @IBAction func selectSex(_ sender: UIButton) {
        viewModel?.updateSex(sender.tag == 0 ? "男性" : "女性")
    }
    
    @IBAction func selectEducation(_ sender: UIButton) {
        
        let buttonSheetVC = storyboard?.instantiateViewController(identifier: "BottomSheetViewController") as! BottomSheetViewController
        let vm = BottomSheetViewModel()
        vm.setEducation(education: sender.configuration?.title ?? "學士")
        vm.sentSelectedEducation = { [weak self] education in
            self?.viewModel?.updateEducation(education)
        }
        buttonSheetVC.setVC(viewModel: vm)
        
        if let sheetPresentationController = buttonSheetVC.sheetPresentationController {
            sheetPresentationController.detents = [.custom(resolver: { context in
                return buttonSheetVC.getVCTotalHeigh()
            })]
        }
        present(buttonSheetVC, animated: true)
    }
    
    @IBAction func agreeRule(_ sender: UIButton) {
        viewModel?.toggleAgreeRule()
        let currentImageName = (viewModel?.isAgreeRule ?? false) ? "checkmark.circle" : "circle"
        agreeRule.configuration?.image = UIImage(systemName: currentImageName)
    }
    
    @IBAction func register(_ sender: Any) {
        viewModel?.register(account: account.text, password: password.text, users: loadUsers())
    }
}

extension RegisterViewController {
    private func bindViewModel() {
        
        viewModel?.errorMessage = { [weak self] massage in
            DispatchQueue.main.async(execute:  {
                self?.errorMessage.text = massage
            })
        }
        
        viewModel?.registerSuccess = { [weak self] newUser in
            DispatchQueue.main.async {
                self?.showAlert(title: "註冊成功", message: "帳號：\(newUser.account)\n密碼：\(newUser.password)\n性別：\(newUser.sex ?? "")\n學歷：\(newUser.education ?? "")") {
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        }
        
        viewModel?.sexChanged = { [weak self] sex in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.male.configuration?.image = (sex == "男性") ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle")
                self.female.configuration?.image = (sex == "女性") ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle")
            }
        }
        
        viewModel?.educationChange = { [weak self] education in
            self?.education.configuration?.title = education
        }
    }
}
