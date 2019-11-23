//
//  FoodsCollectionViewCell.swift
//  FoodStuff
//
//  Created by JiaChen(: on 23/11/19.
//  Copyright © 2019 Aakash Sanjay Mehta. All rights reserved.
//

import UIKit

class FoodsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var featureImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var daysToExpire: UILabel!
    @IBOutlet weak var backgroundColorIndicatorView: UIView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
}
