//
//  ViewController.swift
//  FoodStuff
//
//  Created by Aakash Sanjay Mehta on 23/11/19.
//  Copyright © 2019 Aakash Sanjay Mehta. All rights reserved.
//

import UIKit
import FirebaseDatabase
import CoreML
import ImageIO
import Vision

var items: [Food] = []

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var ref: DatabaseReference!
    var selectedItem: Food!
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    // Classification
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            /*
             Use the Swift class `MobileNet` Core ML generates from the model.
             To use a different Core ML classifier model, add it to the project
             and replace `MobileNet` with that model's generated Swift class.
             */
            let model = try VNCoreMLModel(for: Fruit().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to loale Vision ML model: \(error)")
        }
    }()
    
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
        
        createDummyData()
        customiseSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionview.reloadData()
    }
    
    func createDummyData() {
        let data = [Food(name: "Chicken", expiryDate: Date(), storageInfo: "alive")]
        
        items += data
    }
    
    // MARK: - UI Customisation
    func customiseSearchBar() {
        
    }
    
    
    @IBAction func openVision(_ sender: Any) {
        // @AAKASH
        // Show options for the source picker only if the camera is available.
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            presentPhotoPicker(sourceType: .photoLibrary)
            return
        }
        self.presentPhotoPicker(sourceType: .camera)
    }
    
    // MARK: - Collection View
    // Collection View Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = items[indexPath.row]
        performSegue(withIdentifier: "chicken", sender: nil)
    }
    
    // Collection View Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FoodsCollectionViewCell
        
        cell.backgroundColorIndicatorView.layer.cornerRadius = 16
        cell.widthConstraint.constant = (UIScreen.main.bounds.width - 60) / 2
        cell.foodNameLabel.text = items[indexPath.row].name
        
        let timeToExpire = Int(round(items[indexPath.row].expiryDate.timeIntervalSinceNow / 60 / 60 / 24))
        if timeToExpire == 0 {
            cell.backgroundColorIndicatorView.backgroundColor = .systemRed
            cell.daysToExpire.text = "EXPIRED"
        } else if timeToExpire <= 7 {
            cell.backgroundColorIndicatorView.backgroundColor = .systemYellow
            cell.daysToExpire.text = "\(timeToExpire) days to expiry"
        } else {
            cell.backgroundColorIndicatorView.backgroundColor = UIColor(red: 57/255, green: 62/255, blue: 76/255, alpha: 1)
            cell.daysToExpire.text = "\(timeToExpire) days to expiry"
        }
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "chicken" {
            let dest = segue.destination as! ChickenViewController
            dest.item = selectedItem
        }
    }
    
}

