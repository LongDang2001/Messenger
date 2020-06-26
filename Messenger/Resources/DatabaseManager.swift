//
//  DatabaseManager.swift
//  Messenger
//
//  Created by admin on 6/22/20.
//  Copyright © 2020 Long. All rights reserved.
//

import Foundation
import FirebaseDatabase

// final lớp này không được thực hiện để phân lớp, gọi là lớp cơ sở dữ liệu.

final class DatabaseManager {
    
    static let shared = DatabaseManager() // static là kiểu singgleton đc phép truy cập mọi nơi.
    
    private let database = Database.database().reference()
    
    // cơ sở dữ liệu  hoạt động kiểu json, các khoá và dối tương của hàm child.
    
    
   
}
// MARK: Account Manager

extension DatabaseManager {
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void )) {
        // thay thế một số ký tự, phù hợp với việc đăng ký tài khoản.
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
    }
    
    // chèn người dùng mới vào cơ sở dữ liệu.
    public func inserUser(with user: ChatAppUser) {
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastname
            
        ])
    }
}
struct ChatAppUser {
    let firstName: String
    let lastname: String
    let emailAddress: String
//    let profirePictureUrl: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
}
