//
//  TeamTableViewController.swift
//  sportsapp
//
//  Created by iOS Training on 3/7/21.
//  Copyright © 2021 iOS Training. All rights reserved.
//
import UIKit
import Alamofire
import SDWebImage

class TeamTableViewController: UITableViewController {

    @IBAction func backBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    
    var idddd : String = "133652"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("load\(idddd)")
        loadJsonData()
        
    }
    
    
    func loadJsonData(){
        print(idddd)
        let req = NSURLRequest(URL: NSURL.init(string: "https://www.thesportsdb.com/api/v1/json/1/lookupteam.php?id=\(idddd)")!)
        
        Alamofire.request(req).responseJSON{
            (response)  in
            
            if let json = response.result.value {
          
                let team = json["teams"]!![0]
                let t = Team(name: team["strTeam"] as! String, year: team["intFormedYear"] as! String, league: team["strLeague"] as! String, country: team["strCountry"] as! String, website: team["strWebsite"] as! String, image: team["strTeamBadge"]as! String)
                
                
                self.nameLabel.text = t.name
                self.yearLabel.text = t.year
                self.leagueLabel.text = t.league
                self.countryLabel.text = t.country
                self.websiteLabel.text = t.website
                
                self.myImageView.sd_setImageWithURL(NSURL(string:t.image!))
                
                
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    }
