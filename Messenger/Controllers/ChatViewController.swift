//
//  ChatViewController.swift
//  Messenger
//
//  Created by admin on 6/30/20.
//  Copyright © 2020 Long. All rights reserved.
//

import UIKit
import  MessageKit

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind

}

struct Sender: SenderType {
    // hiển thị ảnh người gửi
    var photoURL: String
    // id người gửi tin nhắn
    var senderId: String
    
    // tên hiển thị ngươì gửi
    var displayName: String
    
}

class ChatViewController: MessagesViewController {

    private var messages = [Message]()
    private let selfSender = Sender(photoURL: "",
                                    senderId: "1",
                                    displayName: "long")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hiển thị tin nhắn khi gửi trên viewChat.
        messages.append(Message(sender: selfSender,
                                messageId: "1",
                                sentDate: Date(),
                                kind: .text("hello wordl mesenger")))
        messages.append(Message(sender: selfSender,
                                messageId: "1",
                                sentDate: Date(),
                                kind: .text("hello wordl mesenger  hello wordl mesenger")))
        
        
        

        view.backgroundColor = .red
        // giống với tableView, hiểu các phương thức triển khai tiếp theo
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
       
    }
  

}

extension ChatViewController: MessagesLayoutDelegate, MessagesDisplayDelegate, MessagesDataSource {
    func currentSender() -> SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
        
    }
    
    
}
