//
//  File.swift
//  FoodStuff
//
//  Created by Sebastian Choo on 23/11/19.
//  Copyright © 2019 Aakash Sanjay Mehta. All rights reserved.
//

import Foundation
struct Food {
    var name: String
    var expiryDate: Date
    var storageInfo: String
    
    static func dateToSec(day: Int) -> Int{
        let seconds = day*24*60*60
        return seconds
    }
}
struct itemsToDontate {
    var id: Int
    var item: String
    var quantity: Int
    var origin: Any
}
