//
//  ChatRoomVM.swift
//  WorkTraining8501
//
//  Created by Labe on 2025/3/18.
//

import Foundation
import UIKit

class ChatRoomVM {
    
    var chatContent: [Message] = []
    var userName = "Labe"
    var isKeyboardShow: Bool = false
    var isStickerShow: Bool = false
    let stickers = (1...18).map { "sticker\($0)" }
    
    var onDataUpdated: (() -> Void)?
    var sentStickerName: ((String) -> Void)?
    
    func randomName() -> String {
        let names: [String] = ["Candy", "Tim", "Josh"]
        return names.randomElement() ?? ""
    }
    
    func randomText() -> String {
        let text: [String] = ["Hi!!", "哈囉", "今天天氣真好", "hi👋", "大家好","你好嗎～？", "哈囉～我是個愛笑又有點搞怪的人，喜歡挑戰新事物，生活每天都精彩！", "很高興見到您！", "嗨，最近怎麼樣？", "安安！"]
        return text.randomElement() ?? ""
    }
    
    func sortedMessage() {
        let sortedMessage = chatContent.sorted { $0.time < $1.time }
        chatContent = sortedMessage
        saveMessagesData(chatContent: chatContent)
    }
    
    func createMessage(text: String?, stickerName: String?) {
        let newMessage: Message
        
        if text != nil {
            newMessage = Message(name: userName, time: Date(), text: text)
        } else if stickerName != nil {
            newMessage = Message(name: userName, time: Date(), sticker: stickerName)
        } else { return }
        chatContent.append(newMessage)
        onDataUpdated?()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.randomReply()
        }
    }
    
    func randomReply() {
        let messages = [
            Message(name: randomName(), time: Date(), text: randomText()),
            Message(name: randomName(), time: Date(), text: randomText()),
            Message(name: randomName(), time: Date(), text: randomText()),
            Message(name: randomName(), time: Date(), sticker: "sticker\(Int.random(in: 1...7))")
        ]
        
        if let replyMessage = messages.randomElement() {
            chatContent.append(replyMessage)
            onDataUpdated?()
        }
    }
    
    func clearMessages() {
        chatContent.removeAll()
        onDataUpdated?()
    }
    
    func scrollToBottom(tableView: UITableView, animated: Bool) {
        DispatchQueue.main.async {
            let lastRow = tableView.numberOfRows(inSection: 0) - 1
            if lastRow >= 0 {
                let indexPath = IndexPath(row: lastRow, section: 0)
                tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
        }
    }
    
    func saveMessagesData(chatContent: [Message]) {
        if let chatContentData = try? JSONEncoder().encode(chatContent) {
            UserDefaults.standard.set(chatContentData, forKey: "chatContentData")
        } else {
            print("🔴chatContent儲存失敗")
        }
    }
    
    func loadMessagesData() -> [Message] {
        if let chatContentData = UserDefaults.standard.data(forKey: "chatContentData") {
            do {
                return try JSONDecoder().decode([Message].self, from: chatContentData)
            } catch {
                print("🔴讀取資料失敗：\(error.localizedDescription)")
                return []
            }
        } else {
            return []
        }
    }
}
