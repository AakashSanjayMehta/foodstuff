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
    
    @IBOutlet weak var swipeIndicator: UIView!
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
        let timeToExpire = round((item.expiryDate.timeIntervalSinceReferenceDate - date.timeIntervalSinceReferenceDate)/60/60/24)
        if timeToExpire <= 0 {
            timeToExpiryLabel.text = "EXPIRED"
            self.view.backgroundColor = .systemRed
        } else if timeToExpire <= 7 {
            timeToExpiryLabel.text = "\(timeToExpire) days to expiry"
            self.view.backgroundColor = .systemYellow
        } else {
            timeToExpiryLabel.text = "\(timeToExpire) days to expiry"
        }
        
        recommendationsLabel.text = Parser().getData()[item.name.lowercased()]?.storage
        
        foodImageView.image = UIImage(named: item.name.lowercased()) ?? UIImage()
        
        foodImageView.layer.shadowColor = UIColor.black.cgColor
        foodImageView.layer.shadowOpacity = 0.6
        foodImageView.layer.shadowOffset = CGSize(width: 0, height: 20)
        foodImageView.layer.shadowRadius = 10
        foodImageView.clipsToBounds = false
        foodImageView.superview!.clipsToBounds = false
        
        swipeIndicator.layer.cornerRadius = 2
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
