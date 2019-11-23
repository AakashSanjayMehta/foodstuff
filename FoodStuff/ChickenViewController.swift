//
//  ChickenViewController.swift
//  FoodStuff
//
//  Created by JiaChen(: on 23/11/19.
//  Copyright © 2019 Aakash Sanjay Mehta. All rights reserved.
//

import UIKit

class ChickenViewController: UIViewController {

    var item: Food!
    
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var timeToExpiryLabel: UILabel!
    @IBOutlet weak var recommendationsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        foodNameLabel.text = item.name
        recommendationsLabel.text = item.storageInfo
        
        #warning("make sure the if else is correct")
        let timeToExpire = Int(round(item.expiryDate.timeIntervalSinceNow / 60 / 60 / 24))
        if timeToExpire == 0 {
            timeToExpiryLabel.text = "EXPIRED"
        } else if timeToExpire <= 7 {
            timeToExpiryLabel.text = "\(timeToExpire) days to expiry"
        } else {
            timeToExpiryLabel.text = "\(timeToExpire) days to expiry"
        }
        
        recommendationsLabel.text = Parser().getData()[item.name.lowercased()]?.storage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
