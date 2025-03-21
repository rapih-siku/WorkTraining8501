//
//  LogInViewController.swift
//  Colatour
//
//  Created by Labe on 2025/3/5.
//

import UIKit

extension LoginViewController {
    func setVC(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var register: UIButton!
    
    private var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        account.delegate = self
        password.delegate = self
        
        bindViewModel()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func bindViewModel() {
        
        viewModel?.errorMessage = { [weak self] message in
            DispatchQueue.main.async {
                self?.errorMessage.text = message
            }
        }
        
        viewModel?.loginSuccessMessage = { [weak self] message in
            DispatchQueue.main.async {
                self?.showAlert(title: nil, message: message) {
                    let productVC = self?.storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
                    self?.navigationController?.pushViewController(productVC, animated: true)
                }
            }
        }
    }
    
    @IBAction func login(_ sender: Any) {
        viewModel?.onTouchLogin(account: account.text, password: password.text, users: loadUsers())
    }
    
    @IBAction func toRegister(_ sender: Any) {
        let registerVC = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        let vm = RegisterViewModel()
        
        print("產生 RegisterViewModel 實例：\(vm)")
        
        vm.registerSuscess = { [weak self] newUser in
            DispatchQueue.main.async {
                print("得到新註冊的使用者資料了")
                self?.account.text = newUser.account
                self?.password.text = ""
                self?.errorMessage.text = ""
            }
        }
        registerVC.setVC(viewModel: vm)
        present(registerVC, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        errorMessage.text = nil
        return true
    }
}
