//
//  ViewController.swift
//  RottenClient
//
//  Created by Alex Choi on 9/12/14.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//

import UIKit
//import LLARingSpinnerView

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var movieTableView: UITableView!
    var moviesArray: NSArray?
    var imageCache = [String : UIImage]()
//    var spinner: UIView?
//    var spinner = LLARingSpinnerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let YourApiKey = "duaw9v2zg9h2grgc9dyzk3gq"
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + YourApiKey
        let request = NSMutableURLRequest(URL: NSURL.URLWithString(RottenTomatoesURLString))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            
//            RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleWave];
//            [self.view addSubview:spinner];
            
//            self.view.addSubview(view: self.spinner as UIView)
//            self.spinner.
            
//            if self.spinner == nil {
//                self.spinner = RTSpinKitView(initWithStyle: .RT
//            }
//            var spinner = RTS
//            self.spinner = LLARingSpinnerView
            
            var errorValue: NSError? = nil
            let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
            
            self.moviesArray = (dictionary["movies"] as? NSArray)

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
        
        let movie = MovieModel(fromNSDictionary: self.moviesArray![indexPath.row] as NSDictionary)
        
        cell.titleLabel.text = movie.title
        cell.imageView?.image = UIImage(named: "Poster128.png")
        //
        var image = self.imageCache[movie.posterThumbnailUrl()]
        
        if( image == nil ) {
            // If the image does not exist, we need to download it
            var imgURL: NSURL = NSURL(string: movie.posterThumbnailUrl())
            
            // Download an NSData representation of the image at the URL
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                if error == nil {
                    image = UIImage(data: data)
                    
                    // Store the image in to our cache
                    self.imageCache[movie.posterThumbnailUrl()] = image
                    if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
                        cellToUpdate.imageView?.image = image
                    }
                }
                else {
                    println("Error: \(error.localizedDescription)")
                }
            })
            
        }
        else {
            dispatch_async(dispatch_get_main_queue(), {
                if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
                    cellToUpdate.imageView?.image = image
                }
            })
        }
        //
        
        return cell
    }

     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let selectedCell = sender as UITableViewCell
        let selectedIndex = self.movieTableView!.indexPathForSelectedRow()
        
        if let row = selectedIndex?.row {
            let movieDictionary = self.moviesArray![row] as NSDictionary;
            let movieDetailController = segue.destinationViewController as MovieDetailViewController;

            movieDetailController.movie = MovieModel(fromNSDictionary: movieDictionary)
        }
    }
}

