//
//  ViewController.swift
//  FirstScreen
//
//  Created by iOS Training on 2/20/21.
//  Copyright © 2021 iOS Training. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class SportViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var sports : [Sport] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadJsonData()
    }
    
    func loadJsonData(){
        
        let req = NSURLRequest(URL: NSURL.init(string: "https://www.thesportsdb.com/api/v1/json/1/all_sports.php")!)
        
        Alamofire.request(req).responseJSON{
            (response)  in
            
            if let json = response.result.value {
            
                for i in 0..<json["sports"]!!.count{
                    
                    let sport = json["sports"]!![i]
                    let s = Sport(title: sport["strSport"] as! String, image: sport["strSportThumb"] as! String)
                    
                    self.sports.append(s)
                    self.collectionView.reloadData()
                    
                }
                
                
            }
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath:indexPath) as!CollectionViewCell
        cell.myLabel.text = sports[indexPath.row].title
        
        cell.myImageView.sd_setImageWithURL(NSURL(string: sports[indexPath.row].image!))
        
        cell.backgroundColor = UIColor.blueColor()
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let controller =  self.storyboard?.instantiateViewControllerWithIdentifier("tb") as? TableViewController
        controller!.type = sports[indexPath.row].title!
        self.presentViewController(controller!, animated: true, completion: nil)
        
        
        
        
    }
    

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.495, height: self.view.frame.height * 0.2)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1;
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 1, left: 2, bottom: 1, right: 2)
   }
    


}


