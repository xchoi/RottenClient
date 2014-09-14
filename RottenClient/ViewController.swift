//
//  ViewController.swift
//  RottenClient
//
//  Created by Alex Choi on 9/12/14.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var movieTableView: UITableView!
    var moviesArray: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let YourApiKey = "duaw9v2zg9h2grgc9dyzk3gq"
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + YourApiKey
        let request = NSMutableURLRequest(URL: NSURL.URLWithString(RottenTomatoesURLString))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
            
            self.moviesArray = dictionary["movies"] as? NSArray
            self.movieTableView.reloadData()
        })
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moviesArray != nil {
            return moviesArray!.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell { 
        let cell = movieTableView.dequeueReusableCellWithIdentifier("com.codepath.rottenclient.moviecell") as MovieTableViewCell
        
        let movieDictionary = self.moviesArray![indexPath.row] as NSDictionary
        
        cell.titleLabel.text = movieDictionary["title"] as NSString
        return cell
    }

     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let selectedCell = sender as UITableViewCell
        let selectedIndex = self.movieTableView!.indexPathForSelectedRow()
        
        if let row = selectedIndex?.row {
            let movieDictionary = self.moviesArray![row] as NSDictionary;
            let movieDetailController = segue.destinationViewController as MovieDetailViewController;

            movieDetailController.movieDetails = movieDictionary
        }
    }
}

