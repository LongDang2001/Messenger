//
//  SceneDelegate.swift
//  Messenger
//
//  Created by admin on 6/20/20.
//  Copyright © 2020 Long. All rights reserved.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    // let tabbarControllers = TabbarController()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
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
        
        
        Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "Email") ?? "", password: UserDefaults.standard.string(forKey: "PassWord") ?? "") { (dataResuld, error) in
            guard error == nil else {
                window.rootViewController = LoginController()
                return
            }
            window.rootViewController = tabbarController
        }
        
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

