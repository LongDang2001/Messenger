//
//  PersonController.swift
//  Messenger
//
//  Created by admin on 7/23/21.
//  Copyright © 2021 Long. All rights reserved.
//

import UIKit
import FirebaseAuth

class PersonController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.green
    }
    
    @IBAction func btLogoutTest(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "Email")
            UserDefaults.standard.removeObject(forKey: "PassWord")
            customPopLogin()
            
        } catch {
            print(error)
        }
        
    }
    func customPopLogin() {
        let loginNavi = LoginController()
        loginNavi.modalTransitionStyle = .crossDissolve
        loginNavi.modalPresentationStyle = .fullScreen

        self.present(loginNavi, animated: true, completion: nil)
    }
}
