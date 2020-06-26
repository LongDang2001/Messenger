//
//  ProfileViewController.swift
//  Messenger
//
//  Created by admin on 6/20/20.
//  Copyright © 2020 Long. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var data: [String] = ["log out"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self

    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Cánh báo người dùng khi họ bấm đăng xuất.
        let actionSheet = UIAlertController(title: "Wood",
                                      message: "You definitely want to log out",
                                      preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Log out",
                                            style: .destructive,
                                            handler: {[weak self] _ in
                    guard let strongSelf = self else {
                        return
                    }
                    // đăng xuất khỏi faceBook.
                    FBSDKLoginKit.LoginManager().logOut()
                    
                    // đăng xuất khỏi google khi đăng nhập bằng google.
                    GIDSignIn.sharedInstance()?.signOut()
                                                
                    do {
                        try FirebaseAuth.Auth.auth().signOut()
                        
                        // Khi người dùng bấm đăng xuất, sau đó vào lại thì sẽ vào chỗ đăng nhập.
                        let vc = LoginViewController()
                        let nav = UINavigationController(rootViewController: vc)
                        nav.modalPresentationStyle = .fullScreen
                        strongSelf.present(nav, animated: true, completion: nil)
                        
                    } catch {
                        print("Fall to log out")
                    }
        }))
        // khi người dùng không muốn đăng suất nữa.
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
        
        
        
    }
}
