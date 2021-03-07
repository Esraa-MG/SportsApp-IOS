//
//  TableViewCell.swift
//  sportsapp
//
//  Created by iOS Training on 2/28/21.
//  Copyright © 2021 iOS Training. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell{
    

    var mydelegate : demo?
    var recieveUrl : String?
    
    @IBOutlet weak var myButton: UIButton!
    @IBAction func videoDemo(sender: AnyObject) {
        
        mydelegate?.buttonSelected(recieveUrl!)

        
    }
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
