//
//  LoginViewController.swift
//  Messenger
//
//  Created by admin on 6/20/20.
//  Copyright © 2020 Long. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView() // tạo closure  
        scrollView.clipsToBounds = true
        return scrollView
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
    
    private let loginButton: UIButton = {
       let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit // tỉ lệ của hình
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
        loginButton.addTarget(self,
                              action: #selector(loginButtonTapped),
                              for: .touchUpInside)
        
        // Khi người dùng nhấn đi nhấn lại giữa 2 văn bản,
        emailField.delegate = self
        passwordField.delegate = self
        
        
        // Add Subview, dùng để hiển thị lên màn hình khi máy mở
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
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
        emailField.frame = CGRect(x: 30,
                                      y: imageView.bottom+10,
                                      width: scrollView.width-60,
                                      height: 52)
        passwordField.frame = CGRect(x: 30,
                                      y: emailField.bottom+10,
                                      width: scrollView.width-60,
                                      height: 52)
        loginButton.frame = CGRect(x: 30,
                                   y: passwordField.bottom+10,
                                   width: scrollView.width-60,
                                   height: 52)
        
    }
    
    //  sau khi người dùng đăng nhập xong,  xử lý việc đăng nhập đc hoàn thành
    @objc private func loginButtonTapped() {
        
        // dùng để loại bỏ bàn phím cho cả hai trường hợp
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        // kiểm tra xem văn bản email, pass có trống không.
        guard let email = emailField.text, let password = passwordField.text,
            !email.isEmpty, !password.isEmpty, password.count >= 6  else {
                alertUserLoginError()
                return }
        
        // Firebase Log In
        // vào phần đăng nhập người dùng.
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {[weak self] // không tạo thêm chu kỳ dữ
            authResult, error in
            
            guard let strongSelf = self else { return }
            guard let result = authResult, error == nil else {
                print("error user login ")
                return
            }
            // làm thông báo login cho mk.in ra màn hình.
            let user = result.user
            print("the user login: \(user)")
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            
        })
        
    }
    
    // hàm nói với người dùng cần phải đăng nhập.
    func alertUserLoginError() {
        let alear = UIAlertController(title: "Wood",
                                      message: "Plese enter information to log in",
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
extension LoginViewController: UITextFieldDelegate {
    // hàm được gọi khi người dùng quay trở lại
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder() // trường pass ko đc thực hiện
        } else if textField == passwordField {
            loginButtonTapped() // nhấn nút đăng nhập.
            
        }
        
        return true
    }
}