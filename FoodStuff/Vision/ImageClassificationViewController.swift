//
//  ImageClassificationViewController.swift
//  FoodStuff
//
//  Created by Aakash Sanjay Mehta on 23/11/19.
//  Copyright © 2019 Aakash Sanjay Mehta. All rights reserved.
//

import UIKit
import CoreML
import Vision
import ImageIO

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    // MARK: - Image Classification
    
    /// - Tag: PerformRequests
    func updateClassifications(for image: UIImage) {
        print("Classifying...")
        
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))!
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                /*
                 This handler catches general image processing errors. The `classificationRequest`'s
                 completion handler `processClassifications(_:error:)` catches errors specific
                 to processing that request.
                 */
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    
    /// Updates the UI with the results of the classification.
    /// - Tag: ProcessClassifications
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                print("Unable to classify image.\n\(error!.localizedDescription)")
                return
            }
            // The `results` will always be `VNClassificationObservation`s, as specified by the Core ML model in this project.
            let classifications = results as! [VNClassificationObservation]
            
            if classifications.isEmpty {
                print("Nothing recognized.")
            } else {
                // Display top classifications ranked by confidence in the UI.
                let bestClassification = classifications.prefix(1)
                let descriptions = bestClassification.map { classification in
                    // Formats the classification for display; e.g. "(0.37) cliff, drop, drop-off".
//                    return String(format: "  (%.2f) %@", classification.confidence, classification.identifier)
                    return String(classification.identifier)
                }
                print("Classification:\n" + descriptions.joined(separator: "\n"))
                print(Parser().getData()[descriptions[0]]?.storage)
                print(items)
                print(date + (Parser().getData()[descriptions[0]]?.durationFridge)!)
                //save data
                items.append(Food(name: descriptions[0], expiryDate: date + (Parser().getData()[descriptions[0]]?.durationFridge)!, storageInfo: Parser().getData()[descriptions[0]]!.storage))
                
            }
        }
    }
    
    // MARK: - Photo Actions
    
    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
        
    }
    
    // MARK: - Handling Image Picker Selection
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        let image = info[.originalImage] as! UIImage
//        imageView.image = image
        updateClassifications(for: image)
    }
}
