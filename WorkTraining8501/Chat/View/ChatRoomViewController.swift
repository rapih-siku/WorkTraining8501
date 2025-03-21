//
//  ChatViewController.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/17.
//

import UIKit

extension ChatRoomViewController {
    func setVC(viewModel: ChatRoomVM) {
        self.viewModel = viewModel
    }
}

class ChatRoomViewController: UIViewController {
    
    @IBOutlet weak var chatRoom: UITableView!
    @IBOutlet weak var inputMessage: UITextView!
    @IBOutlet weak var showStickers: UICollectionView!
    @IBOutlet weak var backgroundHeight: NSLayoutConstraint!
    
    private var viewModel: ChatRoomVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatRoom.dataSource = self
        chatRoom.delegate = self
        showStickers.dataSource = self
        showStickers.delegate = self
        
        inputMessage.layer.cornerRadius = 10
        
        bindViewModel()
        setKeyboardNotification()
        dismissKeyboardOnTap()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func sentMessage(_ sender: Any) {
        guard let text = inputMessage.text, !text.isEmpty else { return }
        viewModel?.createMessage(text: text, stickerName: nil)
        inputMessage.text = ""
    }
    
    @IBAction func showSticker(_ sender: Any) {
        inputMessage.resignFirstResponder()
        
        viewModel?.isStickerShow.toggle()
        
        UIView.animate(withDuration: 0.25) {
            if self.viewModel?.isStickerShow == true {
                self.showStickers.isHidden = false
                self.backgroundHeight.constant = self.view.frame.height * 0.3
            } else {
                self.closeStickers()
            }
        }
        view.layoutIfNeeded()
    }
    
    @IBAction func clearMessage(_ sender: Any) {
        viewModel?.clearMessages()
    }
}

extension ChatRoomViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.chatContent.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let message = viewModel?.chatContent[indexPath.row] else { fatalError() }
        
        if message.name == viewModel?.userName, message.sticker == nil {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SentMessageTableViewCell.reuseIdentifier, for: indexPath) as? SentMessageTableViewCell else { fatalError() }
            cell.selectionStyle = .none
            cell.setCell(message: message)
            return cell
        } else if message.name == viewModel?.userName, message.sticker != nil {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SentStickerTableViewCell.reuseIdentifier, for: indexPath) as? SentStickerTableViewCell else { fatalError() }
            cell.selectionStyle = .none
            cell.setCell(message: message)
            return cell
        } else if message.name != viewModel?.userName, message.sticker == nil {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReceivedMessageTableViewCell.reuseIdentifier, for: indexPath) as? ReceivedMessageTableViewCell else { fatalError() }
            cell.selectionStyle = .none
            cell.setCell(message: message)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReceivedStickerTableViewCell.reuseIdentifier, for: indexPath) as? ReceivedStickerTableViewCell else { fatalError() }
            cell.selectionStyle = .none
            cell.setCell(message: message)
            return cell
        }
    }
}

extension ChatRoomViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.stickers.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerCollectionViewCell.reuseIdentifier, for: indexPath) as? StickerCollectionViewCell else { fatalError() }
        cell.setCell(stickerName: viewModel?.stickers[indexPath.item] ?? "")
        cell.setCellSize(collectionView: showStickers)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? StickerCollectionViewCell else { fatalError() }
        guard let stickerName = cell.sticker.accessibilityIdentifier else { return }
        viewModel?.createMessage(text: nil, stickerName: stickerName)
    }
}

extension ChatRoomViewController {
    private func bindViewModel() {
        
        viewModel?.scrollToBottom(tableView: chatRoom,animated: false)
        
        viewModel?.onDataUpdated = { [weak self] in
            self?.viewModel?.sortedMessage()
            self?.view.endEditing(true)
            self?.chatRoom.reloadData()
            self?.viewModel?.scrollToBottom(tableView: self?.chatRoom ?? UITableView(),animated: true)
        }
    }
    
    private func closeStickers() {
        self.showStickers.isHidden = true
        self.backgroundHeight.constant = 0
    }
}

// 鍵盤監聽
extension ChatRoomViewController {
    private func dismissKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        chatRoom.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
        closeStickers()
        self.viewModel?.isStickerShow = false
    }
    
    private func setKeyboardNotification() {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        let keyboardHeight = keyboardFrame.height
        let newHeight = UIScreen.main.bounds.height - keyboardHeight
        
        if viewModel?.isKeyboardShow == false  {
            self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y, width: self.view.frame.width, height: newHeight)
            closeStickers()
            self.view.layoutIfNeeded()
            
            self.viewModel?.isKeyboardShow = true
            self.viewModel?.isStickerShow = false
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y, width: self.view.frame.width, height: UIScreen.main.bounds.height)
        self.viewModel?.isKeyboardShow = false
    }
}
