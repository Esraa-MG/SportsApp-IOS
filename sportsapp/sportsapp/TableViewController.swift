//
//  TableViewController.swift
//  sportsapp
//
//  Created by iOS Training on 2/24/21.
//  Copyright © 2021 iOS Training. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire



class TableViewController: UITableViewController , demo{

    
    
    @IBAction func backBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    var leagues : [Leagues] = []
    var leaguesName : [String] = []
    
    var ids :[String] = []
    var type : String = "Soccer"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        fetchData()
        
       }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagues.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       // let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! TableViewCell

        // Configure the cell...
        cell.myLabel.text = leagues[indexPath.row].strLeague
        cell.myLabel.numberOfLines = 0
        cell.myImage?.sd_setImageWithURL(NSURL(string: leagues[indexPath.row].strBadge!), placeholderImage: UIImage(named: "sport.jpeg"))
        cell.mydelegate = self
        cell.recieveUrl = leagues[indexPath.row].strYoutube
        if leagues[indexPath.row].strYoutube == ""{
            cell.myButton.enabled = false
        }

        return cell
    }
    
    func buttonSelected(videoUrl : String) {
        let videoView = self.storyboard?.instantiateViewControllerWithIdentifier("videoView") as? ViewController
        videoView!.urlString = "https://\(videoUrl)"
        print(videoView?.urlString)
        self.presentViewController(videoView!, animated: true, completion: nil)

    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print(leagues[indexPath.row].idLeague)
        
        let controller =  self.storyboard?.instantiateViewControllerWithIdentifier("events") as? LeagueDetailsViewController
        controller!.idLeague = leagues[indexPath.row].idLeague
        controller!.strBadge = leagues[indexPath.row].strBadge
        controller!.strLeague = leagues[indexPath.row].strLeague
        controller!.strYoutube = leagues[indexPath.row].strYoutube
        self.presentViewController(controller!, animated: true, completion: nil)
        
        
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let videoView = self.storyboard?.instantiateViewControllerWithIdentifier("videoView") as? ViewController
//        videoView!.urlString = "https://" + leagues[0].strYoutube!
//        self.navigationController?.pushViewController(videoView!, animated: true)
//        print("here")
   // }
    
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func fetchData() {
        // 1
        let req = NSURLRequest(URL: NSURL.init(string: "https://www.thesportsdb.com/api/v1/json/1/all_leagues.php")!)
        Alamofire.request(req).responseJSON{
            (response) -> Void in
                if let JSON = response.result.value{
                    for i in 0..<JSON["leagues"]!!.count{
                      let lea = JSON["leagues"]!![i]
                        let l1 = (lea["strSport"] as? String)!
                        self.leaguesName.append(l1)
                        
                       let strName = lea["strSport"] as! String
                         if strName == self.type{
                            let ii = lea["idLeague"] as! String
                            self.ids.append(ii)
                        }
                    }
            }
            
            for j in 0..<self.ids.count{
            
             let req2 = NSURLRequest(URL: NSURL.init(string: "https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id=\(self.ids[j])")!)
            Alamofire.request(req2).responseJSON{
                (response) -> Void in
                if let JSON2 = response.result.value{
                    
                    let lea = JSON2["leagues"]!![0]
                    if (lea["strBadge"] as? String) != nil{
                        let l1 = Leagues(strLeague: (lea["strLeague"] as? String)!, strBadge: (lea["strBadge"] as? String)!, strYoutube: (lea["strYoutube"] as? String)!, idLeague: (lea["idLeague"] as? String)!)
                        self.leagues.append(l1)
                    }
                    
                    self.tableView.reloadData()
                }}}
   }
}
}
