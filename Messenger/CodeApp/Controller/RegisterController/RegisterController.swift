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
            
            Auth.auth().createUser(withEmail: email, password: passWord) { (authDataResult, error) in
                guard error == nil else {
                    return
                }
                self.pushUserOnDatabase()
                self.customPushNavi()
                
            }
            
        }
    
        func customPushNavi() {
            let mesengerNavi = MessengerController()
            mesengerNavi.modalTransitionStyle = .crossDissolve
            mesengerNavi.modalPresentationStyle = .fullScreen

            self.present(mesengerNavi, animated: true, completion: nil)
            
        }
        
        func pushUserOnDatabase() {
            // MARK: PUSH DATA LEN SERVER
            let userCurrent = Auth.auth().currentUser
            
            let ref: DatabaseReference!
            
            ref = Database.database().reference()
            
            ref.child("users").setValue([
                "key": ["string"],
                "name": "aaaaaaa",
                "bbbbb": "cccccc"
            ], withCompletionBlock: { (error, referenc) in
                
            })
            
    //        ref.child("users").updateChildValues(["email": txtEmail.text ?? ""])
    //        ref.child("users").updateChildValues(["passWord": txtPassWord.text ?? ""])
    //
    //        ref.child("users").updateChildValues(["userName": txtName.text ?? ""])
    //        ref.child("users").updateChildValues(["userPhone": userCurrent?.phoneNumber ?? "defauld"])
            
    //        ref.child("users").child(userCurrent!.uid).updateChildValues(["userStatus": "offline"])
    //        ref.child("users").child(userCurrent!.uid).updateChildValues(["userId": userCurrent?.uid ?? "defauld"])
    //        ref.child("users").child(userCurrent!.uid).updateChildValues(["userImgUrl": userCurrent?.photoURL ?? "defauld"])
        }
        
        @IBAction func btActionDangNhap(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }

}
