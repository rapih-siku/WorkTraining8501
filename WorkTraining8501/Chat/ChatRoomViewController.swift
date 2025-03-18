//
//  ChatViewController.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/17.
//

import UIKit

class ChatRoomViewController: UIViewController {

    @IBOutlet weak var chatRoom: UITableView!
    @IBOutlet weak var inputMessage: UITextView!
    @IBOutlet weak var sentMessage: UIButton!
    
    private var viewModel: ChatRoomVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatRoom.dataSource = self
        chatRoom.delegate = self
        
        inputMessage.layer.cornerRadius = 10
        
        bindViewModel(ChatRoomVM())
    }
    
    @IBAction func sentMessage(_ sender: Any) {
        viewModel?.createNewMessage(text: inputMessage.text)
        inputMessage.text = ""
    }
}

extension ChatRoomViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.chatContent.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let message = viewModel?.chatContent[indexPath.row] else { fatalError() }
        
        if message.name == viewModel?.userName {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SentMessageTableViewCell", for: indexPath) as? SentMessageTableViewCell else { fatalError() }
            cell.setCell(message: message)
            viewModel?.onDataUpdated = { [weak self] in
                self?.chatRoom.reloadData()
                self?.viewModel?.scrollToBottom(tableView: self?.chatRoom ?? UITableView(), animated: true)
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReceivedMessageTableViewCell", for: indexPath) as? ReceivedMessageTableViewCell else { fatalError() }
            cell.setCell(message: message)
            viewModel?.onDataUpdated = { [weak self] in
                self?.chatRoom.reloadData()
                self?.viewModel?.scrollToBottom(tableView: self?.chatRoom ?? UITableView(),animated: true)
            }
            return cell
        }
    }
}

extension ChatRoomViewController {
    private func bindViewModel(_ viewModel: ChatRoomVM) {
        self.viewModel = viewModel
        
        viewModel.createChatContent()
        viewModel.scrollToBottom(tableView: chatRoom,animated: false)
    }
}
