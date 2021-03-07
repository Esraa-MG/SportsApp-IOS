//
//  TeamsCollectionViewCell.swift
//  sportsapp
//
//  Created by iOS Training on 3/3/21.
//  Copyright © 2021 iOS Training. All rights reserved.
//

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myImage: UIImageView!{
        didSet {
            myImage.layer.borderColor = UIColor.grayColor().CGColor
            myImage.layer.borderWidth = 0.5
            myImage.layer.masksToBounds = true
            myImage.layer.cornerRadius = myImage.bounds.width / 2
        }
    }

    
    
    
}
