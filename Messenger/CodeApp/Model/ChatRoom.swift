//
//  ChatRoom.swift
//  Messenger
//
//  Created by admin on 7/25/21.
//  Copyright © 2021 Long. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
class ChatRoom {
    
    var roomId: String
    var participant: DataUser?
    var chatMessenger: [DataChat]
    
    init(snapShot: DataSnapshot ) {
        self.roomId = snapShot.key
        
        // Lấy đc các mảng của modle DataChat:
        self.chatMessenger = (snapShot.children.allObjects as? [DataSnapshot])?.map {
            DataChat(snapShot: $0)
            
            } ?? []
        
        print(snapShot.key)
        
    }
    
    func requestToUser(completionHandle: @escaping (DataChat) -> Void) {
        let ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("chats").observe(.value, with: { (dataSnap) in
            // Handle Data Resuld, handle data with model:
            
            // Handle closure về một mảng các data Model của DataChat:
            let chatRoom = ( DataChat(snapShot: dataSnap))
            
        }, withCancel: { (error) in
            print(error)
        })
        
    }
    
}
