//
//  FavTableViewCell.swift
//  sportsapp
//
//  Created by iOS Training on 3/4/21.
//  Copyright © 2021 iOS Training. All rights reserved.
//

import UIKit

class FavTableViewCell: UITableViewCell {
    
    var mydelegate : demo?
    var recieveUrl : String?
    
    @IBAction func btnAction(sender: AnyObject) {
        
        mydelegate?.buttonSelected(recieveUrl!)
    }

    @IBOutlet weak var myButtton: UIButton!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!{
        didSet {
            myImage.layer.borderColor = UIColor.grayColor().CGColor
            myImage.layer.borderWidth = 0.5
            myImage.layer.masksToBounds = true
            myImage.layer.cornerRadius = myImage.bounds.width / 2
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
