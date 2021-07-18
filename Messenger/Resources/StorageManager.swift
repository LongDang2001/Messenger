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
    public typealias uploadPictureCompletion = (Result<String, Error>) -> Void
    public func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping uploadPictureCompletion ) {
        storage.child("images/\(fileName)").putData(data, metadata: nil, completion: { metadata, error in
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
                
                let urlString = url.absoluteString
                print("dowload url  returned: \(urlString)")
                completion(.success(urlString))
            })
        })
    }
    public enum StorgeError:Error {
        case failedToUpload
        case failedToGetDowloadUrl
    }
}

