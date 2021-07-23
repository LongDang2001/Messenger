//
//  LoginController.swift
//  Messenger
//
//  Created by admin on 7/22/21.
//  Copyright © 2021 Long. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassWord: UITextField!
    @IBOutlet weak var btDangNhap: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customLogin()
        
    }
    func customLogin() {
        // TextField
        let imgEmail = UIImageView(image: UIImage(named: "mail (3) 1"))
        let imgPassWord = UIImageView(image: UIImage(named: "key 1"))
        
        txtEmail.rightViewMode = .always
        txtPassWord.rightViewMode = .always
        txtEmail.rightView = imgEmail
        txtPassWord.rightView = imgPassWord
        
        btDangNhap.layer.cornerRadius = CGFloat(20)
        
        
    }
    @IBAction func emailDidEditing(_ sender: Any) {
        
        btDangNhap.backgroundColor = UIColor(rgb: 0xff4356B4)
    }
    
    
    @IBAction func btActionQuenMatKhau(_ sender: Any) {
        
    }
    
    @IBAction func btActionDangNhap(_ sender: Any) {
        let email = txtEmail.text ?? ""
        let passWord = txtPassWord.text ?? ""
        
        Auth.auth().signIn(withEmail: email , password: passWord) { (authDataResult, error) in
            guard error == nil else {
                return
            }
            self.customPushNavi()


        }
        
        
    }
    
    func customPushNavi() {
        
        let mesengerNavi = MessengerController()
        mesengerNavi.modalTransitionStyle = .crossDissolve
        mesengerNavi.modalPresentationStyle = .fullScreen

        self.present(mesengerNavi, animated: true, completion: nil)
        
    }
    
    @IBAction func btActionDangKyNgay(_ sender: Any) {
        self.present(RegisterController(), animated: true, completion: nil)
        
    }

}
