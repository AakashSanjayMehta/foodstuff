//
//  ManualViewController.swift
//  FoodStuff
//
//  Created by Sebastian Choo on 23/11/19.
//  Copyright © 2019 Aakash Sanjay Mehta. All rights reserved.
//

import UIKit

class ManualViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    
    private var datePicker: UIDatePicker?
    var foodName: String = ""
    var expiryDate: Date = Date()
    var newFood: Food = Food(name: "", expiryDate: Date(), storageInfo: "")
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action:  #selector(ManualViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ManualViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        inputTextField.inputView = datePicker
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer ) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        inputTextField.text = dateFormatter.string(from: datePicker.date)
        expiryDate = datePicker.date
    }
        
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        newFood = Food(name: foodName, expiryDate: expiryDate, storageInfo: "")
    }
}

