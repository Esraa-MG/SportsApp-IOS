//
//  Leagues.swift
//  sportsapp
//
//  Created by iOS Training on 2/27/21.
//  Copyright © 2021 iOS Training. All rights reserved.
//

import UIKit

class Leagues {
    
    var strLeague : String?
    var strYoutube : String?
    var strBadge : String?
    var idLeague : String?

    
    init(strLeague: String, strBadge: String, strYoutube : String, idLeague : String){
       self.strLeague = strLeague
       self.strBadge = strBadge
       self.strYoutube = strYoutube
        self.idLeague = idLeague
    }

}
