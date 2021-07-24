//
//  PushDataOnMessenger.swift
//  Messenger
//
//  Created by admin on 7/24/21.
//  Copyright © 2021 Long. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase

class PushDataOnMessenger {
    
    // Push data FAKE on firebase:
    func pushDataOnfirebase() {
         
        let ref: DatabaseReference!
        ref = Database.database().reference()
        
        guard let currentUser = Auth.auth().currentUser else {
            return
            
        }
        // Add Date
        //var calendar = Calendar.current
        let date = Date()
        let formaterDate = DateFormatter()
        formaterDate.locale = .current
        formaterDate.dateStyle = .medium
        formaterDate.timeZone = .current
        formaterDate.dateFormat = "MM/dd/yyyy"
        
        let formaterTime = DateFormatter()
        formaterTime.locale = .current
        formaterTime.timeStyle = .short
        formaterTime.timeZone = .current
        formaterTime.dateFormat = "h:mm"
        
        let formaterTimeLong = DateFormatter()
        formaterTimeLong.locale = .current
        formaterTimeLong.timeStyle = .long
        formaterTimeLong.timeZone = .current
       
        
        let time = Timer()
        
        let dataPush: [String: Any] = [
            "date" : formaterDate.string(from: date),
            "idReceiver": currentUser.uid,
            "idSender": "zx0rZGSPnFYhAQy6MUIWUXbrMfa2",
            "messenger": " Hôm nay trời đẹp thế nhờ",
            "time": formaterTime.string(from: date),
            "timeLong": formaterTimeLong.string(from: date),
        ]
        
        ref.child("chats").child((currentUser.uid) + "zx0rZGSPnFYhAQy6MUIWUXbrMfa2").childByAutoId().updateChildValues(dataPush, withCompletionBlock: { (error, data) in
            
            guard error == nil else {
                return
            }
            
        })
    }
}
