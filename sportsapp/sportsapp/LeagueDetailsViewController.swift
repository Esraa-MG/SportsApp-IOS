//
//  LeagueDetailsViewController.swift
//  sportsapp
//
//  Created by iOS Training on 3/1/21.
//  Copyright © 2021 iOS Training. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import CoreData

class LeagueDetailsViewController: UIViewController {
    
    @IBOutlet weak var favBtn: UIButton!

    @IBAction func addFavorite(sender: AnyObject) {
        
        let sv = self.storyboard?.instantiateViewControllerWithIdentifier("SV") as! FavTableViewController
        
        //create object of app delegate
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //create object of manage context
        let manageContext = appDelegate.managedObjectContext
        
        //create entity of movie
        let entity = NSEntityDescription.entityForName("League", inManagedObjectContext: manageContext)
        
        //create manage object
        let league = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: manageContext)
        
        league.setValue(idLeague, forKey: "idLeague")
        league.setValue(strLeague, forKey: "strLeague")
        league.setValue(strBadge, forKey: "strBadge")
        league.setValue(strYoutube, forKey: "strYoutube")
        
        
        //save changes
        do{
            try manageContext.save()
        }catch let error{
            print(error)
        }
        
        sv.league.append(league)
        sv.tableView.reloadData()
        
        
    }
   
    @IBOutlet weak var coll1: UICollectionView!

    @IBOutlet weak var coll2: UICollectionView!
  
    @IBOutlet weak var coll3: UICollectionView!
    
    var teamofLeague : [TeamDetails] = []
    
    var leaguesDetails : [LeagueDetails] = []
    
    var idLeague: String?
    var strLeague: String?
    var strBadge: String?
    var strYoutube: String?
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        fetchDetails(idLeague!)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(sender: AnyObject) {
    
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == coll2 || collectionView == coll1){
            return leaguesDetails.count
        }
        return teamofLeague.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if (collectionView == coll1){
            
            
                        let cell = coll1.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! EventsCollectionViewCell
                        cell.eventName.text = leaguesDetails[indexPath.row].strEvent
                        cell.eventName.numberOfLines = 0
                        cell.eventDate.text = leaguesDetails[indexPath.row].dateEvent
                        cell.eventDate.numberOfLines = 0
                        cell.eventTime.text = leaguesDetails[indexPath.row].strTime
                        cell.eventTime.numberOfLines = 0
                        return cell
            
        }else if(collectionView == coll2){
            
            let cell2 = coll2.dequeueReusableCellWithReuseIdentifier("cell2", forIndexPath: indexPath) as! ResultsCollectionViewCell
            
                            cell2.teamOne.text = leaguesDetails[indexPath.row].strHomeTeam
                            cell2.teamOne.numberOfLines = 0
                            cell2.teamTwo.text = leaguesDetails[indexPath.row].strAwayTeam
                            cell2.teamTwo.numberOfLines = 0
                            cell2.resultOne.text = leaguesDetails[indexPath.row].intHomeScore
                            cell2.resultOne.numberOfLines = 0
                            cell2.resultTwo.text = leaguesDetails[indexPath.row].intAwayScore
                            cell2.resultTwo.numberOfLines = 0
                            return cell2
            
        }else{
            let cell3 = coll3.dequeueReusableCellWithReuseIdentifier("cell3", forIndexPath: indexPath) as! TeamsCollectionViewCell
            
                            cell3.myImage?.sd_setImageWithURL(NSURL(string: teamofLeague[indexPath.row].strTeamBadge!), placeholderImage: UIImage(named: "sport.jpeg"))
                            return cell3
        }

    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == coll3{
            
            let controller =  self.storyboard?.instantiateViewControllerWithIdentifier("team") as? TeamTableViewController
            controller!.idddd = teamofLeague[indexPath.item].idTeam!
            print("mine\(teamofLeague[indexPath.row].idTeam)")
            self.presentViewController(controller!, animated: true, completion: nil)
            
        }
        
        
    }
    
    
    
    
    
    func fetchDetails(idLeague : String)  {
        let req = NSURLRequest(URL: NSURL.init(string: "https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id=\(idLeague)")!)
        Alamofire.request(req).responseJSON{
            (response) -> Void in
            if let JSON = response.result.value{
              if let _ = JSON["events"]!![0]{
                for i in 0..<JSON["events"]!!.count{
                    let det = JSON["events"]!![i]
                    if (det["idEvent"] as? String != nil && det["strEvent"] as? String != nil && det["strAwayTeam"] as? String != nil && det["strHomeTeam"] as? String != nil && det["intHomeScore"] as? String != nil && det["intAwayScore"] as? String != nil && det["dateEvent"] as? String != nil && det["strTime"] as? String != nil){
                    let d1 = LeagueDetails(idEvent: (det["idEvent"] as? String)!, strEvent: (det["strEvent"] as? String)!, strHomeTeam: (det["strHomeTeam"] as? String)!, strAwayTeam: (det["strAwayTeam"] as? String)!, intHomeScore: (det["intHomeScore"] as? String)!, intAwayScore: (det["intAwayScore"] as? String)!, dateEvent: (det["dateEvent"] as? String)!, strTime: (det["strTime"] as? String)!)
                    
                    self.leaguesDetails.append(d1)
                        self.coll1.reloadData()
                        self.coll2.reloadData()
                        self.coll3.reloadData()
                    }
                }}
                else{
                    let d1 = LeagueDetails(idEvent: "not found", strEvent: "not found", strHomeTeam: "not found", strAwayTeam: "not found", intHomeScore: "not found", intAwayScore: "not found", dateEvent: "not found", strTime: "not found")
                    self.leaguesDetails.append(d1)
                    self.coll1.reloadData()
                    self.coll2.reloadData()
                    self.coll3.reloadData()
                }
                
            }}
        
        let req1 = NSURLRequest(URL: NSURL.init(string: "https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=\(idLeague)")!)
        Alamofire.request(req1).responseJSON{
            (response) -> Void in
            if let JSON1 = response.result.value{
                for j in 0..<JSON1["teams"]!!.count{
                    let team = JSON1["teams"]!![j]
                    if team["idTeam"] as? String != nil && team["strTeamBadge"] as? String != nil{
                        let t1 = TeamDetails(idTeam: (team["idTeam"] as? String)!, strTeamBadge: (team["strTeamBadge"] as? String)!)
                        self.teamofLeague.append(t1)
                        self.coll3.reloadData()
                        self.coll1.reloadData()
                        self.coll2.reloadData()
                    }
                    
                }
                
            }
        }

    }
    }
