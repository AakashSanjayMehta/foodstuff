//
//  AlertViewController.swift
//  FoodStuff
//
//  Created by JiaChen(: on 24/11/19.
//  Copyright © 2019 Aakash Sanjay Mehta. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var curvedView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        curvedView.layer.cornerRadius = 20
        curvedView.clipsToBounds = true
    }
    
    @IBAction func dismisss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
