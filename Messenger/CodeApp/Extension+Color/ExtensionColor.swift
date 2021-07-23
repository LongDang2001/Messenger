//
//  ExtensionColor.swift
//  Messenger
//
//  Created by admin on 7/23/21.
//  Copyright © 2021 Long. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255)
        assert(green >= 0 && green <= 255)
        assert(blue >= 0 && blue <= 255)
        
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
        
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
        
    }
    
}
