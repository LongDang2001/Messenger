//
//  HeaderMessenger.swift
//  Messenger
//
//  Created by admin on 7/24/21.
//  Copyright © 2021 Long. All rights reserved.
//

import UIKit

class HeaderMessenger: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lbTinNhan: UILabel!
    @IBOutlet weak var imgIconChat: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        customFileXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customFileXib()
    }
    
    func customFileXib() {
        Bundle.main.loadNibNamed("HeaderMessenger", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        
        //MARK: Layer color:
        let layer0 = CAGradientLayer()  
        
        layer0.colors = [
          UIColor(red: 0.263, green: 0.337, blue: 0.706, alpha: 1).cgColor,
          UIColor(red: 0.239, green: 0.812, blue: 0.812, alpha: 1).cgColor
        ]
        layer0.bounds = contentView.bounds.insetBy(dx: -0.2*contentView.bounds.size.width, dy: -0.2*contentView.bounds.size.height)
        layer0.position = contentView.center
        contentView.layer.addSublayer(layer0)
        contentView.addSubview(lbTinNhan)
        contentView.addSubview(imgIconChat)
        contentView.addSubview(searchBar)
    }
}
