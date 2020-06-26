//
//  AppDelegate.swift
//  Messenger
//
//  Created by admin on 6/20/20.
//  Copyright © 2020 Long. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions )
        
        // ví dụ chia sẻ id khách hàng, là firebase.
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        
        return true
    }
    
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    func application( _ app: UIApplication,
                      open url: URL,
                      options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
        
        // hàm khi ta đăng nhập vào web.
         return GIDSignIn.sharedInstance().handle(url)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    // chức năng có sẵn khi protocol GIDSignInDelegate.chức năng này được gọi khi người dùng đăng nhập thành công.
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else {
            if let error = error {
                print("Faile signIn with google: \(error)")
            }
            return
        }
        guard let user = user else { return }
        print("did sign in with google: \(user)")
        
        guard let email = user.profile.email,
            let firstName = user.profile.givenName,
            let lastName = user.profile.familyName
        else {
            return
        }
        // Kiểm tra trước khi đưa emai khi đăng nhập bằng google vào fireBase.
        DatabaseManager.shared.userExists(with: email, completion: { exists in
            if !exists {
                // chền đến cở dữ liệu nếu người dùng tôn tại.
                DatabaseManager.shared.inserUser(with: ChatAppUser(firstName: firstName,
                                                                   lastname: lastName,
                                                                   emailAddress: email))
            }
        })
        
        
        // mã thông báo cho google.
        guard let authentication = user.authentication else {
            print(" Missing out object of google ")
            return
            
        }
        // có được thông tin bằng cách gọi google
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        FirebaseAuth.Auth.auth().signIn(with: credential, completion: { authReult, error in
            guard authReult != nil, error == nil else {
                print("faile to log in with google credential ")
                return
            }
            print("Success fully signed in the google")
            NotificationCenter.default.post(name: .didLogInNotification, object: nil)
        })
    }
    // hàm đã kết nối với người dùng
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Google user was disconnected ")
    }
    
}



    
