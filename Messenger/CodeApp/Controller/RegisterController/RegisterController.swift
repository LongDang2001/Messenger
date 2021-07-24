//
//  RegisterController.swift
//  Messenger
//
//  Created by admin on 7/23/21.
//  Copyright © 2021 Long. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassWord: UITextField!
    @IBOutlet weak var btDangKy: UIButton!
//    let checkPassEmail = CheckPassEmail()
//    let serverRegister = ServerRegister()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customRegister()
        
    }
    
    func customRegister() {
            txtPassWord.rightViewMode = .always
            txtEmail.rightViewMode = .always
            txtName.rightViewMode = .always
            txtPassWord.rightView = UIImageView(image: UIImage(named: "key 1"))
            txtEmail.rightView = UIImageView(image: UIImage(named: "mail (3) 1"))
            txtName.rightView = UIImageView(image: UIImage(named: "user 2"))
            
            btDangKy.layer.cornerRadius = CGFloat(20)
            
        }
        
        
        @IBAction func btBackButton(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }
        
        @IBAction func didEndEditName(_ sender: Any) {
            btDangKy.backgroundColor = UIColor(rgb: 0xff4356B4)
        }
        
        @IBAction func btChinhSach(_ sender: Any) {
        }
        
        @IBAction func btDichVu(_ sender: Any) {
        }
        
        @IBAction func btActionDangKy(_ sender: Any) {
           
            let email = txtEmail.text ?? ""
            let passWord = txtPassWord.text ?? ""
            
            
            guard (passWord.count > 8) == true else {
                return
            }
            
            Auth.auth().createUser(withEmail: email, password: passWord) { (authDataResult, error) in
                guard error == nil else {
                    return
                }
                
                UserDefaults.standard.set(email, forKey: "Email")
                UserDefaults.standard.set(passWord, forKey: "PassWord")
                
                self.pushUserOnDatabase()
                self.customPushNavi()
                
            }
            
        }
    
//    // MARK: CHECK VALIST EMAIL
//        func isValidEmail(_ email: String) -> Bool {
//            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//
//            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//            return emailPred.evaluate(with: email)
//        }
//
//        func isValidPassWord(_ passWord: String) -> Bool {
//            let passWordRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//            let passWordPred = NSPredicate(format:"", passWordRegEx)
//            return passWordPred.evaluate(with: passWord)
//        }
    
        func customPushNavi() {
            
            let messengerController = MessengerController()
            messengerController.tabBarItem = UITabBarItem(title: "Tin nhắn", image: UIImage(named: "Group-3")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "Vector (1)" )?.withRenderingMode(.alwaysOriginal))
            
            let friendController = FriendController()
             friendController.tabBarItem = UITabBarItem(title: "Bạn bè", image: UIImage(named: "Group")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "Group-2")?.withRenderingMode(.alwaysOriginal))
            
            let personController = PersonController()
            personController.tabBarItem = UITabBarItem(title: "Trang cá nhân", image: UIImage(named: "Group (1)")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "Group-1")?.withRenderingMode(.alwaysOriginal))
            
            let tabbarController = UITabBarController()
            tabbarController.viewControllers = [
                messengerController,
                friendController,
                personController
            ]
            
            let tabbarNavi = tabbarController
            tabbarNavi.modalTransitionStyle = .crossDissolve
            tabbarNavi.modalPresentationStyle = .fullScreen
            self.present(tabbarNavi, animated: true, completion: nil)
            
        }
        
        func pushUserOnDatabase() {
            // MARK: PUSH DATA LEN SERVER
            
            let ref: DatabaseReference!
            ref = Database.database().reference()
            guard let userCurrent = Auth.auth().currentUser else {
                return
            }
            
            ref.child("users/\(userCurrent.uid)").updateChildValues(["email": txtEmail.text ?? ""])
            ref.child("users/\(userCurrent.uid)").updateChildValues(["passWord": txtPassWord.text ?? ""])
            ref.child("users/\(userCurrent.uid)").updateChildValues(["userName": txtName.text ?? ""])
            ref.child("users/\(userCurrent.uid)").updateChildValues(["userPhone": userCurrent.phoneNumber ?? "defauld"])
            ref.child("users/\(userCurrent.uid)").updateChildValues(["userStatus": "offline"])
            ref.child("users/\(userCurrent.uid)").updateChildValues(["userId": userCurrent.uid])
            ref.child("users/\(userCurrent.uid)").updateChildValues(["userImgUrl": userCurrent.photoURL ?? "defauld"])
            
        }
        
        @IBAction func btActionDangNhap(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }

}
