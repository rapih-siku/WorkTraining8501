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
    
    var onDataUpdated: (() -> Void)?
    
    func createChatContent() {
        chatContent = [
            Message(name: randomName(), time: randomTime(), text: randomText()),
            Message(name: randomName(), time: randomTime(), text: randomText()),
            Message(name: randomName(), time: randomTime(), text: randomText()),
            Message(name: randomName(), time: randomTime(), text: randomText()),
            Message(name: randomName(), time: randomTime(), text: randomText()),
            Message(name: userName, time: randomTime(), text: randomText()),
            Message(name: randomName(), time: randomTime(), text: randomText()),
            Message(name: randomName(), time: randomTime(), text: randomText()),
            Message(name: userName, time: randomTime(), text: randomText()),
            Message(name: userName, time: randomTime(), text: randomText())
        ]
        sortedMessage()
    }
    
    func randomName() -> String {
        let names: [String] = ["Candy", "Tim", "Josh"]
        return names.randomElement() ?? ""
    }
    
    func randomTime() -> Date {
        let now = Date() // 取得現在時間
        let threeDaysAgo = Calendar.current.date(byAdding: .day, value: -3, to: now)! // 3天前的時間
        let randomTimeInterval = TimeInterval.random(in: threeDaysAgo.timeIntervalSince1970...now.timeIntervalSince1970) // 隨機選擇時間
        return Date(timeIntervalSince1970: randomTimeInterval) // 轉換為 Date 物件
    }
    
    func randomText() -> String {
        let text: [String] = ["Hi!!", "哈囉", "今天天氣真好", "hi👋", "大家好","你好嗎～？", "哈囉～我是個愛笑又有點搞怪的人，喜歡挑戰新事物，生活每天都精彩！", "很高興見到您！", "嗨，最近怎麼樣？", "安安！"]
        return text.randomElement() ?? ""
    }
    
    func sortedMessage() {
        let sortedMessage = chatContent.sorted { $0.time < $1.time }
        chatContent = sortedMessage
        onDataUpdated?()
    }
    
    func createNewMessage(text: String) {
        if text.isEmpty { return }
        let date = Date()
        let newMessage = Message(name: userName, time: date, text: text)
        chatContent.append(newMessage)
        sortedMessage()
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
}
