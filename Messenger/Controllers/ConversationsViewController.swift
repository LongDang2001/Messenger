//
//  ViewController.swift
//  Messenger
//
//  Created by admin on 6/20/20.
//  Copyright © 2020 Long. All rights reserved.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class ConversationsViewController: UIViewController {

    private let spinner = JGProgressHUD(style: .dark)
    
    private let tableView: UITableView = {
        // khai báo tableView theo code, ko khai báo theo kiểu kéo outlet
        let table = UITableView()
        table.isHidden = true // ẩn tableView.
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell") // đặt id của tableViewCell
        return table
    }()
    
    private let noConversationsLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "no ConversationsLabel"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchConversations()
        // tạo một trên thanh bar.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose,
                                                            target: self,
                                                            action: #selector(didTapComposeButton))
        
        view.addSubview(tableView)
        view.addSubview(noConversationsLabel)
        
        
    }
    // phương thức hành động của nút.
    @objc private func didTapComposeButton() {
        let vc = NewConversationViewController()
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true, completion: nil)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // layout tableView bounds tất cả các phần hiện trong view
        tableView.frame = view.bounds
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

   private func  fetchConversations() {
    tableView.isHidden = false
    }

}

extension ConversationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "helleo"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ChatViewController()
        vc.title = "Jenny Smith"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
}
