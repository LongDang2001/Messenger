//
//  RegisterViewController.swift
//  Messenger
//
//  Created by admin on 6/20/20.
//  Copyright © 2020 Long. All rights reserved.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class RegisterViewController: UIViewController {

    private let spinner = JGProgressHUD(style: .dark)
    
    private let scrollView: UIScrollView = {
            let scrollView = UIScrollView() // tạo closure
            scrollView.clipsToBounds = true
            return scrollView
        }()
        
        private let firstNameField: UITextField = {
            let field = UITextField()
            field.autocapitalizationType = .none // Chữ viết hoa tự động
            field.autocorrectionType = .no
            field.returnKeyType = .continue // quay trở về.
            field.layer.cornerRadius = 12 // tạo đường viền cho textField
            field.layer.borderWidth = 1 // Tạo đường border chiều   cho field
            field.layer.borderColor = UIColor.link.cgColor // Tạo đường viền xanh
            field.placeholder = "First Name..."
            
            field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
            // cho dòng Placeholder lùi vào 5.
            field.leftViewMode = .always
            field.backgroundColor = .white
            return field
            
        }()
    
        private let lastNameField: UITextField = {
            let field = UITextField()
            field.autocapitalizationType = .none // Chữ viết hoa tự động
            field.autocorrectionType = .no
            field.returnKeyType = .continue // quay trở về.
            field.layer.cornerRadius = 12 // tạo đường viền cho textField
            field.layer.borderWidth = 1 // Tạo đường border chiều   cho field
            field.layer.borderColor = UIColor.link.cgColor // Tạo đường viền xanh
            field.placeholder = "Last Name..."
            
            field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
            // cho dòng Placeholder lùi vào 5.
            field.leftViewMode = .always
            field.backgroundColor = .white
            return field
            
        }()
        
        private let emailField: UITextField = {
            let field = UITextField()
            field.autocapitalizationType = .none // Chữ viết hoa tự động
            field.autocorrectionType = .no
            field.returnKeyType = .continue // quay trở về.
            field.layer.cornerRadius = 12 // tạo đường viền cho textField
            field.layer.borderWidth = 1 // Tạo đường border chiều   cho field
            field.layer.borderColor = UIColor.link.cgColor // Tạo đường viền xanh
            field.placeholder = "Email Address..."
            
            field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
            // cho dòng Placeholder lùi vào 5.
            field.leftViewMode = .always
            field.backgroundColor = .white
            return field
            
        }()
    
        private let passwordField: UITextField = {
            let field = UITextField()
            field.autocapitalizationType = .none // Chữ viết hoa tự động
            field.autocorrectionType = .no
            field.returnKeyType = .done // tự động đn khi người dùng bấm
            field.layer.cornerRadius = 12 // tạo đường viền cho textField
            field.layer.borderWidth = 1 // Tạo đường border chiều   cho field
            field.layer.borderColor = UIColor.link.cgColor // Tạo đường viền xanh
            field.placeholder = "Password..."
            
            field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
            // cho dòng Placeholder lùi vào 5.
            field.leftViewMode = .always
            field.backgroundColor = .white
            field.isSecureTextEntry = true // nhập văn bản an toàn.
            return field
            
        }()
    
    
        
        private let registerButton: UIButton = {
           let button = UIButton()
            button.setTitle("Register", for: .normal)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 12
            button.layer.masksToBounds = true
            button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
            return button
        }()
        
        private let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "person.circle")
            imageView.tintColor = .gray
            imageView.contentMode = .scaleAspectFit // tỉ lệ của hình
            // bo tròn ảnh.
            imageView.layer.masksToBounds = true
            imageView.layer.borderWidth = 2
            imageView.layer.borderColor = UIColor.lightGray.cgColor
            
            return imageView
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Log In"
            view.backgroundColor = .white
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(didTapRegister))
            
            // Thêm mục tiêu khi hiển thị lên màn hình
            registerButton.addTarget(self,
                                  action: #selector(registerButtonTapped),
                                  for: .touchUpInside)
            
            // Khi người dùng nhấn đi nhấn lại giữa 2 văn bản,
            emailField.delegate = self
            passwordField.delegate = self
            
            
            // Add Subview, dùng để hiển thị lên màn hình khi máy mở
            view.addSubview(scrollView)
            scrollView.addSubview(imageView)
            scrollView.addSubview(emailField)
            scrollView.addSubview(firstNameField)
            scrollView.addSubview(lastNameField)
            scrollView.addSubview(passwordField)
            scrollView.addSubview(registerButton)
            
            imageView.isUserInteractionEnabled = true // tương tác người dùng.
            scrollView.isUserInteractionEnabled = true
            
            let gesture = UITapGestureRecognizer(target: self,
                                                 action: #selector(didTapChangeProfireDic))
            // gesture.numberOfTouchesRequired = 1
            imageView.addGestureRecognizer(gesture)
            
        }
    @objc private func didTapChangeProfireDic() {
        // Lấy ảnh từ thư viện trong thư viện.
        presentPhotoAcctionSheet()
        
        print("i have change gesture")
    }
    
        // hàm thay đổi giao diện khi chưa hiển thị lên màn hình.
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            scrollView.frame = view.bounds // tạo scroll view bằng view
            let size = scrollView.width/3
            imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                     y: 20,
                                     width: size,
                                     height: size)
            imageView.layer.cornerRadius = imageView.width/2.0
            
            firstNameField.frame = CGRect(x: 30,
                                        y: imageView.bottom+10,
                                        width: scrollView.width-60,
                                        height: 52)
            lastNameField.frame = CGRect(x: 30,
                                        y: firstNameField.bottom+10,
                                        width: scrollView.width-60,
                                        height: 52)
            
            emailField.frame = CGRect(x: 30,
                                        y: lastNameField.bottom+10,
                                        width: scrollView.width-60,
                                        height: 52)
            passwordField.frame = CGRect(x: 30,
                                          y: emailField.bottom+10,
                                          width: scrollView.width-60,
                                          height: 52)
            registerButton.frame = CGRect(x: 30,
                                       y: passwordField.bottom+10,
                                       width: scrollView.width-60,
                                       height: 52)
            
        }
        
        //  sau khi người dùng đăng nhập xong,  xử lý việc đăng nhập đc hoàn thành
        @objc private func registerButtonTapped() {
            
            // dùng để loại bỏ bàn phím cho cả hai trường hợp
            firstNameField.resignFirstResponder()
            lastNameField.resignFirstResponder()
            emailField.resignFirstResponder() 
            passwordField.resignFirstResponder()
            
            
            // kiểm tra xem văn bản email, pass có trống không.
            guard let firstName = firstNameField.text,
                let lastName = lastNameField.text,
                let email = emailField.text,
                let password = passwordField.text,
                !firstName.isEmpty,
                !lastName.isEmpty,
                !email.isEmpty,
                !password.isEmpty,
                password.count >= 6  else {
                alertUserLoginError()
                    
                return }
            
            
            spinner.show(in: view)
            
            
            // Firebase Log In
            DatabaseManager.shared.userExists(with: email, completion: { [weak self] exists in
                guard let strongSelf = self else { return }
                
                DispatchQueue.main.async {
                    strongSelf.spinner.dismiss()
                }
                guard !exists else {
                    // người dùng đã thoát.
                    strongSelf.alertUserLoginError(message: "Looks like a user account for the email address already")
                    return
                }
                
                // tạo email và tài khoản người dùng.
                FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {
                    // tạo clpsure có hai tham số đầu vào là authResult và error.
                    authResult, error in
                    // nếu error có giá trị nil thì in ra
                    print("error user ")
                    
                    guard authResult != nil, error == nil else {
                        return
                        
                    }
                    let chatUser = ChatAppUser(firstName: firstName,
                                               lastname: lastName,
                                               emailAddress: email)
                    // tạo người dùng, ghi vào bộ nhớ kiểm soát người dùng.
                    DatabaseManager.shared.inserUser(with: chatUser, completion: { success in
                        if success {
                            // upload user
                            
                            guard let image = strongSelf.imageView.image,
                                let data = image.pngData() else {
                                return
                            }
                            let filename = chatUser.profilePictureFileName
                            StoregeManager.shared.uploadProfilePicture(with: data, fileName: filename, completion: { result in
                                switch result {
                                
                                case .success(let dowloadUrl):
                                    UserDefaults.standard.set(dowloadUrl, forKey: "profile_picture_url")
                                    print(dowloadUrl)
                                case .failure(let error):
                                    print("Storage manager erroe: \(error)")
                                }
                            })
                        }
                    } )
                    strongSelf.navigationController?.dismiss(animated: true, completion: nil)
                })
            })
            
        }
        
        // hàm nói với người dùng cần phải đăng nhập.
        func alertUserLoginError(message: String = "Plese enter information to creat a account") {
            let alear = UIAlertController(title: "Wood",
                                          message: message,
                                          preferredStyle: .alert)
            alear.addAction(UIAlertAction(title: "Dismiss",
                                          style: .cancel,
                                          handler: nil))
            
            present(alear, animated: true, completion: nil)
            
        }
        
        
        // khi người dùng bấm vào nút đk, thì chuyển sang hàm này.
        @objc private func didTapRegister() {
            let vc = RegisterViewController() // VC là chế độ xem đăng ký
            vc.title = "Create Account"
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    // tách mã
    extension RegisterViewController: UITextFieldDelegate {
        // hàm được gọi khi người dùng quay trở lại
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == emailField {
                passwordField.becomeFirstResponder() // trường pass ko đc thực hiện
            } else if textField == passwordField {
                registerButtonTapped() // nhấn nút đăng nhập.
                
            }
            return true
        }
}

// Liên quan đến việc chọn ảnh trong thư viện.
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // cho phép đc chọn ảnh
    func presentPhotoAcctionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture",
                                             message: "How would you like select a picture",
                                             preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancal",
                                            style: .cancel,
                                            handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
         // Không cho referenCouting tăng số lượng, gây lên rò rỉ bộ nhớ.
                                                self?.presentCamara()
                                                
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Chose Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                self?.presentPhotoPicker()
        }))
        
        present(actionSheet, animated: true, completion: nil) // hàm đến cái action
        
    }
    
    func presentCamara() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera // cho người dùng chụp ảnh.
        vc.delegate = self
        vc.allowsEditing = true // Cho phép người dùng chỉnh sửa ảnh.
        present(vc, animated: true, completion: nil)

    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true // Cho phép người dùng chỉnh sửa ảnh.
        present(vc, animated: true, completion: nil)
        
    }
    
    
    // hàm chọn hình ảnh trong thư viện
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        print(info)
        // lấy khoá thông tin, lấy hình ảnh đc chỉnh sửa.
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        self.imageView.image = selectedImage
    }

    // đc gọi khi người dùng huỷ bỏ việc lấy ảnh.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
