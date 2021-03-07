//
//  CollectionViewCell.swift
//  FirstScreen
//
//  Created by iOS Training on 2/20/21.
//  Copyright © 2021 iOS Training. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var myLabel: UILabel!
    
    func setupCell(photo:UIImage,name:String){
        myImageView.image = photo
        myLabel.text = name
    }
}
