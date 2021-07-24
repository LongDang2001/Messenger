//
//  MessengerController.swift
//  Messenger
//
//  Created by admin on 7/23/21.
//  Copyright © 2021 Long. All rights reserved.
//

import UIKit
import FirebaseAuth

class MessengerController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var arrayFake: [String] = ["sdfs","fsdf","sfsd","dfdsf","fdsfs"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableView.backgroundColor = UIColor(rgb: 0xff4356B4)
        tableView.register(UINib(nibName: "MessengerTableViewCell", bundle: nil), forCellReuseIdentifier: "MessengerTableViewCellID")
        
        
        
    }
    
    

}


extension MessengerController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFake.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessengerTableViewCellID", for: indexPath) as! MessengerTableViewCell
        cell.lbText.text = arrayFake[indexPath.row]
        
        return cell
    }
    
    // MARK:CUSTOM HEADER:
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderMessenger()
        if (section == 0) {
            view.backgroundColor = UIColor.cyan
            
        } else {
            view.backgroundColor = UIColor.blue
        }
        
        return view
    }
    
    
    
}

extension MessengerController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
