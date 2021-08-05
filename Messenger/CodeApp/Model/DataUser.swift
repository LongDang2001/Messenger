//
//  ModelUser.swift
//  Messenger
//
//  Created by admin on 7/25/21.
//  Copyright © 2021 Long. All rights reserved.
//

import Foundation
import Firebase

struct DataUser {
    
    var email: String
    var passWord: String
    var userId: String
    var userImgUrl: String
    var userName: String
    var userPhone: String
    var userStatus: String
    
    
    init(snapShot: DataSnapshot) {
        self.email = snapShot.childSnapshot(forPath: "email").value as? String ?? ""
        self.passWord = snapShot.childSnapshot(forPath: "passWord").value as? String ?? ""
        self.userId = snapShot.childSnapshot(forPath: "userId").value as? String ?? ""
        self.userImgUrl = snapShot.childSnapshot(forPath: "userImgUrl").value as? String ?? ""
        self.userName = snapShot.childSnapshot(forPath: "userName").value as? String ?? ""
        self.userPhone = snapShot.childSnapshot(forPath: "userPhone").value as? String ?? ""
        self.userStatus = snapShot.childSnapshot(forPath: "userStatus").value as? String ?? ""
        

    }
    

}
