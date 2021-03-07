//
//  LeagueDetails.swift
//  sportsapp
//
//  Created by iOS Training on 3/1/21.
//  Copyright © 2021 iOS Training. All rights reserved.
//

import UIKit

class LeagueDetails{
    
    var idEvent: String?
    var strEvent: String?
    var strHomeTeam: String?
    var strAwayTeam: String?
    var intHomeScore: String?
    var intAwayScore: String?
    var dateEvent: String?
    var strTime: String?
    
    init(idEvent: String, strEvent: String, strHomeTeam: String, strAwayTeam: String, intHomeScore:String, intAwayScore: String, dateEvent: String, strTime: String){
        
        self.idEvent = idEvent
        self.strEvent = strEvent
        self.strHomeTeam = strHomeTeam
        self.strAwayTeam = strAwayTeam
        self.intHomeScore = intHomeScore
        self.intAwayScore = intAwayScore
        self.dateEvent = dateEvent
        self.strTime = strTime
    }
    
}
