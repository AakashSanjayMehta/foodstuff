//
//  ViewController.swift
//  FoodStuff
//
//  Created by Aakash Sanjay Mehta on 23/11/19.
//  Copyright © 2019 Aakash Sanjay Mehta. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("init")
        ref = Database.database().reference()
        ref.child("Settings").child("Date").observe(.value, with: { (snapshot) in
            let changeddatenum: String = snapshot.value as! String
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let date: Date = dateFormatter.date(from: changeddatenum)!
            print(date)
        })
    }
    
    
}

