//
//  Team.swift
//  LastScreen
//
//  Created by iOS Training on 3/1/21.
//  Copyright © 2021 iOS Training. All rights reserved.
//

import UIKit

class Team {
    
    var name : String?
    var year : String?
    var league : String?
    var country : String?
    var website : String?
    var image : String?
    
    
    init(name : String ,year : String,league : String,country : String,website : String ,image : String){
        self.name = name
        self.year = year
        self.league = league
        self.country = country
        self.website = website
        self.image = image
    }
}
