//
//  FavTableViewController.swift
//  sportsapp
//
//  Created by iOS Training on 3/4/21.
//  Copyright © 2021 iOS Training. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage
import Alamofire

class FavTableViewController: UITableViewController, demo {
    
    
    var league = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        print("view did load")
    }
    
    override func viewWillAppear(animated: Bool) {
        //create object of app delegate
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //create object of manage context
        let manageContext = appDelegate.managedObjectContext
        
        
        //create fetch request
        let fetchRequest = NSFetchRequest(entityName: "League")
        
        do{
            league = try manageContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            self.tableView.reloadData()
        }catch let error{
            print(error)
        }
        
        print("view will appear")

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
        return league.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("favcell") as! FavTableViewCell

        // Configure the cell...
        cell.myLabel?.text = league[indexPath.row].valueForKey("strLeague") as? String
        cell.myLabel.numberOfLines = 0
        cell.myImage?.sd_setImageWithURL(NSURL(string: (league[indexPath.row].valueForKey("strBadge")as? String)!), placeholderImage: UIImage(named: "sport.jpeg"))
        cell.mydelegate = self
       cell.recieveUrl = league[indexPath.row].valueForKey("strYoutube") as? String
        if league[indexPath.row].valueForKey("strYoutube") as? String == ""{
           cell.myButtton.enabled = false
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
        if Reachability.isConnectedToNetwork() == true{
            print("Internet connection OK")
            
            print(league[indexPath.row].valueForKey("idLeague") as? String)
            
          let controller =  self.storyboard?.instantiateViewControllerWithIdentifier("events") as? LeagueDetailsViewController
           controller!.idLeague = league[indexPath.row].valueForKey("idLeague") as? String
           controller!.strBadge = league[indexPath.row].valueForKey("strBadge") as? String
            controller!.strLeague = league[indexPath.row].valueForKey("strBadge") as? String
            controller!.strYoutube = league[indexPath.row].valueForKey("strYoutube") as? String
            self.presentViewController(controller!, animated: true, completion: nil)
            
        } else {
            print("Internet connection FAILED")
            self.Alert("NO INTERNET CONNECTION, PLEASE CONNECT")
        }
        
            }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            //create object of app delegate
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            //create object of manage context
            let manageContext = appDelegate.managedObjectContext
            
            //delete from core date
            manageContext.deleteObject(league[indexPath.row])
        
            league.removeAtIndex(indexPath.row)
            
            //save manage object context
            do{
                try manageContext.save()
            }catch let error{
                print(error)
            }
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
    
    
    func Alert(Message: String){
        let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    

}


