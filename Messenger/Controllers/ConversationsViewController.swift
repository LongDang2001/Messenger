//
//  ViewController.swift
//  Messenger
//
//  Created by admin on 6/20/20.
//  Copyright © 2020 Long. All rights reserved.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .red
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
//        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        
        // khi người dùng đã đăng nhập rồi thì hiển thị vào màn hình khác, khôg hiển thị màn hình đăng nhập nữa.
    }
    private func validateAuth() {
        // nếu tài sản người dùng là nil thì cho thực hiện.
        if FirebaseAuth.Auth.auth().currentUser == nil {
            // tạo một cái view mặc định khi chạy app.
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true, completion: nil)
        }
    }


}

