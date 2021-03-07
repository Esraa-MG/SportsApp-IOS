//
//  ViewController.swift
//  sportsapp
//
//  Created by iOS Training on 2/24/21.
//  Copyright © 2021 iOS Training. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBAction func btnAction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   

    @IBOutlet weak var player1: UIWebView!
   
    var urlString: String?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL(string: urlString!)
        player1.loadRequest(NSURLRequest(URL: url!))
      
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

