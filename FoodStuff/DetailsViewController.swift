//
//  ChickenViewController.swift
//  FoodStuff
//
//  Created by JiaChen(: on 23/11/19.
//  Copyright © 2019 Aakash Sanjay Mehta. All rights reserved.
//

import UIKit
import Foundation

class DetailsViewController: UIViewController {

    var item: Food!
    var value: Int!
    
    @IBOutlet weak var deleteButton: UIView!
    @IBOutlet weak var swipeIndicator: UIView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var timeToExpiryLabel: UILabel!
    @IBOutlet weak var recommendationsLabel: UILabel!
    
    var onDismiss: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        foodNameLabel.text = item.name
        recommendationsLabel.text = item.storageInfo
        
        let timeToExpire = floor((item.expiryDate.timeIntervalSinceReferenceDate - date.timeIntervalSinceReferenceDate)/60/60/24)
        if timeToExpire <= 0 {
            timeToExpiryLabel.text = "EXPIRED"
            self.view.backgroundColor = .systemRed
        } else if timeToExpire <= 7 {
            timeToExpiryLabel.text = "\(Int(timeToExpire)) days to expiry"
            self.view.backgroundColor = .systemYellow
        } else {
            timeToExpiryLabel.text = "\(Int(timeToExpire)) days to expiry"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        timeToExpiryLabel.text = "\(timeToExpiryLabel.text!)\n\(dateFormatter.string(from: item.expiryDate))"
        
        recommendationsLabel.text = Parser().getData()[item.name.lowercased()]?.storage
        
        foodImageView.image = UIImage(named: item.name.lowercased()) ?? UIImage()
        
        foodImageView.layer.shadowColor = UIColor.black.cgColor
        foodImageView.layer.shadowOpacity = 0.6
        foodImageView.layer.shadowOffset = CGSize(width: 0, height: 20)
        foodImageView.layer.shadowRadius = 10
        foodImageView.clipsToBounds = false
        foodImageView.superview!.clipsToBounds = false
        
        swipeIndicator.layer.cornerRadius = 2
        
        deleteButton.layer.cornerRadius = 20
        deleteButton.clipsToBounds = true
    }
    
    @IBAction func deleteFood(_ sender: Any) {
        items.remove(at: value)
        onDismiss?()
        dismiss(animated: true, completion: nil)
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
