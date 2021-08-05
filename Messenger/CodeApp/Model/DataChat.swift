//
//  ModelChat.swift
//  Messenger
//
//  Created by admin on 7/25/21.
//  Copyright © 2021 Long. All rights reserved.
//

import Foundation
import Firebase

struct DataChat {
    
    var date: String
    var idReceiver: String
    var idSender: String
    var messenger: String
    var time: String
    var timeLong: String
    
    init(snapShot: DataSnapshot) {
        self.date = snapShot.childSnapshot(forPath: "date").value as? String ?? ""
        self.idReceiver = snapShot.childSnapshot(forPath: "idReceiver").value as? String ?? ""
        self.idSender = snapShot.childSnapshot(forPath: "idSender").value as? String ?? ""
        self.messenger = snapShot.childSnapshot(forPath: "messenger").value as? String ?? ""
        self.time = snapShot.childSnapshot(forPath: "time").value as? String ?? ""
        self.timeLong = snapShot.childSnapshot(forPath: "timeLong").value as? String ?? ""
        
    }
   

}
