//
//  MovieDetailViewController.swift
//  RottenClient
//
//  Created by Alex Choi on 9/13/14.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movieDetails: NSDictionary?
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    @IBOutlet weak var movieScoreLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        println("viewDidLoad")
        
        if movieDetails != nil {
            
            println("view did load movie dtails")
            
            movieTitleLabel.text =          movieDetails?["title"] as NSString
            movieScoreLabel.text =          String((movieDetails?["ratings"] as NSDictionary)["critics_score"] as NSInteger)
            movieDescriptionTextView.text =    movieDetails?["synopsis"] as NSString
            movieRatingLabel.text =         movieDetails?["mpaa_rating"] as NSString
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
