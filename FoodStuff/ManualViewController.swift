//
//  ManualViewController.swift
//  FoodStuff
//
//  Created by Sebastian Choo on 23/11/19.
//  Copyright © 2019 Aakash Sanjay Mehta. All rights reserved.
//

import UIKit

class ManualViewController: UIViewController {

    @IBOutlet weak var inputNameField: UITextField!
    @IBOutlet weak var inputDateField: UITextField!
    
    var onDismiss: (() -> Void)?
    
    private var datePicker: UIDatePicker?
    var foodName: String = ""
    var expiryDate: Date = Date()
    var newFood: Food = Food(name: "", expiryDate: Date(), storageInfo: "")
    override func viewDidLoad() {
        super.viewDidLoad()

        inputNameField.attributedPlaceholder = NSAttributedString(string:"Enter Product Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 107/255, green: 135/255, blue: 195/255, alpha: 1)])
        inputDateField.attributedPlaceholder = NSAttributedString(string:"Enter Expiry Date", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 107/255, green: 135/255, blue: 195/255, alpha: 1)])
        
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action:  #selector(ManualViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ManualViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        inputDateField.inputView = datePicker
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer ) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        inputDateField.text = dateFormatter.string(from: datePicker.date)
        expiryDate = datePicker.date
    }
        
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        foodName = inputNameField.text!
        newFood = Food(name: foodName, expiryDate: expiryDate, storageInfo: "")
        items.append(newFood)
        onDismiss?()
        print(items)
    }
}

