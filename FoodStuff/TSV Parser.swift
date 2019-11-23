//
//  CSV Parser.swift
//  PortableCL
//
//  Created by JiaChen(: on 27/7/19.
//  Copyright © 2019 SST Inc. All rights reserved.
//

import UIKit
import Foundation

struct OurFood {
    var name: String
    var category: String
    var durationFridge: TimeInterval
    var durationFreezer: TimeInterval
    var storage: String
}

struct Parser {
    // Gives an array of words
    func getData() -> [String: OurFood] {
        // Make a giant array of everything from each level
        // Naming format will be "pcl pX" where X is the level
        // Break it up into arrays
        var returnedDict: [String: OurFood] = [:]
        
        
        var tsvFileAsArray = "data.tsv".contentsOrBlank().components(separatedBy: "\n")
        
        // Remove the first row as they are headers
        tsvFileAsArray.removeFirst()
        
        // Now break the arrays up further. BREAK THE TABS
        var tabbedArrays: [[String]] = []
        for data in tsvFileAsArray {
            let splitArray = String(data).components(separatedBy: "\t")
            tabbedArrays += [splitArray]
        }
        
        tabbedArrays.removeLast()
        // Check first value of array which is lessons to try to create a new, truncated array
        for i in tabbedArrays {
            let category = i[0]
            let name = i[1]
            let durationFridge = i[2]
            let durationFreezer = i[3]
            let storage = i[4]
            
            returnedDict.updateValue(OurFood(name: name, category: category, durationFridge: TimeInterval(durationFridge)!, durationFreezer: TimeInterval(durationFreezer)!, storage: storage), forKey: name.lowercased())
        }
        
        return returnedDict
    }
}

// Get CSV to String
public extension String {
    func contentsOrBlank() -> String {
        if let path = Bundle.main.path(forResource:self , ofType: nil) {
            do {
                let text = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                return text
            } catch { print("Failed to read text from bundle file \(self)") }
        } else { print("Failed to load file from bundle \(self)") }
        return ""
    }
}
