//
//  TabbarController.swift
//  Messenger
//
//  Created by admin on 7/24/21.
//  Copyright © 2021 Long. All rights reserved.
//

import Foundation
import UIKit

class TabbarController {
    
    func tabbarCustom() {
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
        
    }
}
