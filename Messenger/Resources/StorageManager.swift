//
//  StorageManager.swift
//  Messenger
//
//  Created by admin on 7/1/20.
//  Copyright © 2020 Long. All rights reserved.
//

import Foundation
import FirebaseStorage

final class StoregeManager {
    
    static let shared = StoregeManager()

    private let storage = Storage.storage().reference()
    
    // longphan752001-gmail-com_profile_picture.png
    
    // gán bí danh cho việc tải lên hình ảnh.
    public typealias uploadPictureCompletion = (Result<String, Error>) -> Void
    
    // tải hình ảnh lưu trữvaof filebase nếu sai thì thông báp error.
    public func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping uploadPictureCompletion ) {
        // dặt dữ liêu về một dữ liệu mà chúng ta hoàn thành, tương đương với request api đang tải hình ảnh lên
        storage.child("images/\(fileName)").putData(data, metadata: nil, completion: { metadata, error in
            // nhận dữ. liệu tham số cho vào đây là siêu dữ liệu mà nó đc chọn
            guard error == nil else {
                print("faied to upload data to firebase for picture")
                completion(.failure(StorgeError.failedToUpload))
                return
            }
            
            self.storage.child("images\(fileName)").downloadURL(completion: {url, error in
                guard let url = url else {
                    print("failed To Get DowloadUrl ")
                    completion(.failure(StorgeError.failedToGetDowloadUrl))
                    return
                }
                
                // lấy biến thể chỗi thực của  
                let urlString = url.absoluteString
                print("dowload url  returned: \(urlString)")
                completion(.success(urlString))
            })
        })
    }
    public enum StorgeError:Error {
        // tao lỗi dầu tiên không thể tải dữ liệu lên
        case failedToUpload
        // không thể lấy url tải xuống.hãy trả lại lỗi trong phần hoàn thành.
        case failedToGetDowloadUrl
    }
}

