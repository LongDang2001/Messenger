//
//  DatabaseManager.swift
//  Messenger
//
//  Created by admin on 6/22/20.
//  Copyright © 2020 Long. All rights reserved.
//

import Foundation
import Firebase

final class DatabaseManager {
    static let shared = DatabaseManager() // static là kiểu singleton đc phép truy cập mọi nơi.
    private let database = Database.database().reference()
    
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
            print(snapshot.value)
            completion(true)
        })
    }
    
    // chèn người dùng mới vào cơ sở dữ liệu.
    public func inserUser(with user: ChatAppUser, completion: @escaping (Bool) -> Void) {
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastname
            ], withCompletionBlock: { error , _ in
                guard error == nil else {
                    print("failed write database")
                    completion(false)
                    return
                }
                completion(true)
        })
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
    var profilePictureFileName: String {
        return "\(safeEmail)_profile_picture.png"
    }
}
